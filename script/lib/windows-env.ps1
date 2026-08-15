# Shared helpers for Windows source builds: MSVC discovery, Dev Shell, and
# checkpointed steps used by script/windows.ps1 and script/build-windows.ps1.

$script:ZedBuildWindowsStateName = ".build-windows-state.json"

function Resolve-ZedRepoRoot {
    $dir = $PSScriptRoot
    while ($dir) {
        $toolchain = Join-Path $dir "rust-toolchain.toml"
        $zedCrate = Join-Path $dir "crates\zed"
        if ((Test-Path -LiteralPath $toolchain) -and (Test-Path -LiteralPath $zedCrate)) {
            return $dir
        }
        $parent = Split-Path $dir -Parent
        if (-not $parent -or $parent -eq $dir) {
            break
        }
        $dir = $parent
    }
    throw "Could not locate the Zed repository root from $PSScriptRoot"
}

$script:ZedRepoRoot = Resolve-ZedRepoRoot

$script:ZedRequiredVsComponents = @(
    "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre"
)

$script:ZedInstallVsComponents = @(
    "Microsoft.VisualStudio.Workload.VCTools",
    "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre",
    "Microsoft.VisualStudio.Component.Windows11SDK.26100",
    "Microsoft.VisualStudio.Component.VC.CMake.Project"
)

$script:ZedMinWindowsSdk = [version]"10.0.20348.0"

function Get-ZedRepoRoot {
    $script:ZedRepoRoot
}

function Get-ZedWindowsArch {
    switch ([System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture) {
        "X64" { "x86_64" }
        "Arm64" { "aarch64" }
        default { throw "Unsupported architecture: $_" }
    }
}

function Get-ZedVsArch {
    param(
        [Parameter(Mandatory = $true)][string]$Arch
    )

    switch ($Arch) {
        "x86_64" { "amd64" }
        "aarch64" { "arm64" }
        default { throw "Unsupported architecture: $Arch (expected x86_64 or aarch64)" }
    }
}

function Get-ZedWindowsTargetTriple {
    param(
        [Parameter(Mandatory = $true)][string]$Arch
    )

    "$Arch-pc-windows-msvc"
}

function Test-ZedIsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Initialize-ZedCargoPath {
    $cargoHome = if ($env:CARGO_HOME) { $env:CARGO_HOME } else { Join-Path $env:USERPROFILE ".cargo" }
    $bin = Join-Path $cargoHome "bin"
    if ((Test-Path $bin) -and ($env:Path -notlike "*$bin*")) {
        $env:Path = "$bin;$env:Path"
    }
}

function Update-ZedUserPath {
    $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $user = [Environment]::GetEnvironmentVariable("Path", "User")
    $current = $env:Path
    $env:Path = "$machine;$user;$current"
    Initialize-ZedCargoPath
}

function Invoke-ZedNativeCommand {
    param(
        [Parameter(Mandatory = $true)][scriptblock]$Command
    )

    & $Command
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "Command failed with exit code $LASTEXITCODE"
    }
}

function Invoke-ZedOptionalNative {
    param(
        [Parameter(Mandatory = $true)][scriptblock]$Command
    )

    $previous = $false
    $hasNativeEap = Test-Path variable:PSNativeCommandUseErrorActionPreference
    if ($hasNativeEap) {
        $previous = $PSNativeCommandUseErrorActionPreference
        $PSNativeCommandUseErrorActionPreference = $false
    }
    try {
        & $Command
    }
    finally {
        if ($hasNativeEap) {
            $PSNativeCommandUseErrorActionPreference = $previous
        }
    }
}

function Get-ZedVsWhere {
    $candidates = @()
    $cmd = Get-Command vswhere -ErrorAction SilentlyContinue
    if ($cmd) {
        $candidates += $cmd.Source
    }
    $candidates += @(
        (Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe")
        (Join-Path $env:ProgramFiles "Microsoft Visual Studio\Installer\vswhere.exe")
    )

    foreach ($candidate in $candidates) {
        if ($candidate -and (Test-Path -LiteralPath $candidate)) {
            return $candidate
        }
    }

    $null
}

function Get-ZedVsInstallPath {
    param(
        [string[]]$Requires,
        [switch]$AnyInstall
    )

    $vswhere = Get-ZedVsWhere
    if (-not $vswhere) {
        return $null
    }

    if (-not $AnyInstall -and ($null -eq $Requires -or $Requires.Count -eq 0)) {
        $Requires = @("Microsoft.VisualStudio.Component.VC.Tools.x86.x64")
    }

    $vswhereArgs = @("-latest", "-products", "*", "-property", "installationPath")
    foreach ($component in @($Requires)) {
        if ($component) {
            $vswhereArgs += @("-requires", $component)
        }
    }

    $path = Invoke-ZedOptionalNative { & $vswhere @vswhereArgs 2>$null }
    if ($path) {
        return ([string]$path).Trim()
    }

    $null
}

function Get-ZedMissingVsComponents {
    param(
        [string[]]$Components = $script:ZedRequiredVsComponents
    )

    $missing = @()
    foreach ($component in $Components) {
        if (-not (Get-ZedVsInstallPath -Requires @($component))) {
            $missing += $component
        }
    }
    $missing
}

function Enter-ZedVsDevShell {
    param(
        [Parameter(Mandatory = $true)][string]$Architecture,
        [string]$HostArchitecture
    )

    if (-not $HostArchitecture) {
        $HostArchitecture = Get-ZedWindowsArch
    }

    $vsPath = Get-ZedVsInstallPath
    if (-not $vsPath) {
        throw "Visual Studio with MSVC x64/x86 build tools was not found. Run script/windows.ps1 -InstallDeps or install Build Tools manually."
    }

    $launch = Join-Path $vsPath "Common7\Tools\Launch-VsDevShell.ps1"
    if (-not (Test-Path -LiteralPath $launch)) {
        throw "Launch-VsDevShell.ps1 not found at $launch"
    }

    $vsArch = Get-ZedVsArch -Arch $Architecture
    $hostArch = Get-ZedVsArch -Arch $HostArchitecture

    Write-Host "Initializing VS Dev Shell from $vsPath ($vsArch, host $hostArch)"
    Push-Location
    try {
        & $launch -Arch $vsArch -HostArch $hostArch -SkipAutomaticLocation
    }
    finally {
        Pop-Location
    }

    if (-not (Get-Command cl -ErrorAction SilentlyContinue)) {
        throw "cl.exe is not on PATH after initializing the VS Dev Shell. Open a Developer PowerShell or repair Visual Studio."
    }
}

function Find-ZedCmake {
    $cmd = Get-Command cmake -ErrorAction SilentlyContinue
    if ($cmd) {
        return $cmd.Source
    }

    $vsPath = Get-ZedVsInstallPath
    if ($vsPath) {
        $vsCmake = Join-Path $vsPath "Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
        if (Test-Path -LiteralPath $vsCmake) {
            return $vsCmake
        }
    }

    $null
}

function Get-ZedWindowsSdkVersions {
    $kits = Join-Path ${env:ProgramFiles(x86)} "Windows Kits\10\Include"
    if (-not (Test-Path -LiteralPath $kits)) {
        return @()
    }

    Get-ChildItem -LiteralPath $kits -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^\d+\.\d+\.\d+\.\d+$' } |
        ForEach-Object { [version]$_.Name }
}

function Test-ZedWindowsSdk {
    $versions = @(Get-ZedWindowsSdkVersions)
    @($versions | Where-Object { $_ -ge $script:ZedMinWindowsSdk }).Count -gt 0
}

function Get-ZedBuildWindowsStatePath {
    Join-Path (Get-ZedRepoRoot) "target\$script:ZedBuildWindowsStateName"
}

function New-ZedBuildWindowsState {
    param(
        [Parameter(Mandatory = $true)][string]$Profile,
        [Parameter(Mandatory = $true)][string]$Architecture
    )

    [pscustomobject]@{
        profile      = $Profile
        architecture = $Architecture
        completed    = @()
        failedStep   = $null
        lastError    = $null
    }
}

function Get-ZedCompletedSteps {
    param($Completed)

    if ($null -eq $Completed) {
        return @()
    }
    if ($Completed -is [string]) {
        return @($Completed)
    }
    @($Completed)
}

function Get-ZedBuildWindowsState {
    param(
        [Parameter(Mandatory = $true)][string]$Profile,
        [Parameter(Mandatory = $true)][string]$Architecture,
        [switch]$IgnoreExisting
    )

    $path = Get-ZedBuildWindowsStatePath
    if ($IgnoreExisting -or -not (Test-Path -LiteralPath $path)) {
        return New-ZedBuildWindowsState -Profile $Profile -Architecture $Architecture
    }

    $raw = Get-Content -LiteralPath $path -Raw -ErrorAction Stop
    $parsed = $raw | ConvertFrom-Json
    $state = New-ZedBuildWindowsState -Profile $parsed.profile -Architecture $parsed.architecture
    $state.completed = Get-ZedCompletedSteps -Completed $parsed.completed
    $state.failedStep = $parsed.failedStep
    $state.lastError = $parsed.lastError

    if ($state.profile -ne $Profile -or $state.architecture -ne $Architecture) {
        Write-Host "Build configuration changed (was $($state.profile)/$($state.architecture), now $Profile/$Architecture); resetting completed steps."
        return New-ZedBuildWindowsState -Profile $Profile -Architecture $Architecture
    }

    $state
}

function Save-ZedBuildWindowsState {
    param(
        [Parameter(Mandatory = $true)]$State
    )

    $path = Get-ZedBuildWindowsStatePath
    $dir = Split-Path $path -Parent
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    $toSave = [pscustomobject]@{
        profile      = $State.profile
        architecture = $State.architecture
        completed    = @(Get-ZedCompletedSteps -Completed $State.completed)
        failedStep   = $State.failedStep
        lastError    = $State.lastError
    }

    $toSave | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $path -Encoding utf8
}

function Reset-ZedBuildWindowsState {
    param(
        [Parameter(Mandatory = $true)][string]$Profile,
        [Parameter(Mandatory = $true)][string]$Architecture
    )

    $path = Get-ZedBuildWindowsStatePath
    if (Test-Path -LiteralPath $path) {
        Remove-Item -LiteralPath $path -Force
    }

    New-ZedBuildWindowsState -Profile $Profile -Architecture $Architecture
}

function Invoke-ZedBuildStep {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][scriptblock]$Action,
        [Parameter(Mandatory = $true)]$State,
        [switch]$Always,
        [switch]$Resume,
        [scriptblock]$SkipIf
    )

    $completed = Get-ZedCompletedSteps -Completed $State.completed
    $alreadyDone = $Resume -and ($completed -contains $Name)

    if (-not $Always -and $alreadyDone) {
        $shouldSkip = $true
        if ($SkipIf) {
            $shouldSkip = [bool](& $SkipIf)
        }
        if ($shouldSkip) {
            Write-Host "Skipping completed step: $Name"
            return
        }
        Write-Host "Re-running step $Name (resume skip condition failed)"
    }

    Write-Host "==> $Name"
    try {
        & $Action
        if ($completed -notcontains $Name) {
            $completed += $Name
        }
        $State.completed = $completed
        $State.failedStep = $null
        $State.lastError = $null
        Save-ZedBuildWindowsState -State $State
    }
    catch {
        $State.failedStep = $Name
        $State.lastError = $_.Exception.Message
        Save-ZedBuildWindowsState -State $State
        throw
    }
}
