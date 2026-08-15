#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess = $true)]
Param(
    [Parameter()][Alias('h')][switch]$Help,
    [Parameter()][switch]$Build,
    [Parameter()][switch]$NoBuild,
    [Parameter()][switch]$Launch,
    [Parameter()][ValidateSet("stable", "preview", "nightly", "dev")]
    [string]$Channel = "stable",
    [Parameter()][Alias('a')][string]$Architecture,
    [Parameter()][string]$InstallDir,
    [Parameter()][switch]$PinWinget,
    [Parameter()][switch]$NoPinWinget,
    [Parameter()][switch]$Backup,
    [Parameter()][switch]$NoBackup,
    [Parameter()][switch]$Force,
    [Parameter()][int]$Jobs
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

. "$PSScriptRoot/lib/windows-env.ps1"

function Show-DeployWindowsHelp {
    Write-Output @"
Usage: deploy-windows.ps1 [-NoBuild] [-Launch] [-Channel <channel>] [-Architecture <arch>] [-InstallDir <path>] [-Force] [-WhatIf] [-Help]

Build Synth Zed and overlay the existing per-user Windows install
(%LOCALAPPDATA%\Programs\Zed by default). Leaves the official uninstaller
and Explorer Appx package in place.

Options:
  -Build               Build before overlaying (default).
  -NoBuild             Overlay the last release artifacts without building.
  -Launch              Start Zed.exe after a successful overlay.
  -Channel             Release channel compiled into the binaries (default: stable).
  -Architecture, -a    x86_64 or aarch64 (default: host architecture).
  -InstallDir          Overlay destination (default: %LOCALAPPDATA%\Programs\Zed).
  -PinWinget           Pin winget package ZedIndustries.Zed (also the default
                       when that package is installed and not already pinned).
  -NoPinWinget         Do not pin winget.
  -Backup              Copy the current install to <InstallDir>.official-backup
                       (also the default when that backup does not exist yet).
  -NoBackup            Do not copy a backup.
  -Force               Overlay even if the destination does not look like Zed.
  -Jobs                Cargo parallel jobs (default: 2). Raise this on machines
                       with plenty of RAM; thin LTO can crash rustc otherwise.
  -WhatIf              Print actions without stopping processes or writing files.
  -Help, -h            Show this help message.

Examples:
  script/deploy-windows.ps1
  script/deploy-windows.ps1 -NoBuild
  script/deploy-windows.ps1 -Launch
  script/deploy-windows.ps1 -WhatIf
"@
}

if ($Help) {
    Show-DeployWindowsHelp
    exit 0
}

if ($Build -and $NoBuild) {
    throw "Use only one of -Build and -NoBuild."
}
if ($PinWinget -and $NoPinWinget) {
    throw "Use only one of -PinWinget and -NoPinWinget."
}
if ($Backup -and $NoBackup) {
    throw "Use only one of -Backup and -NoBackup."
}

$shouldBuild = -not $NoBuild
$hostArch = Get-ZedWindowsArch
if (-not $Architecture) {
    $Architecture = $hostArch
}
if ($Architecture -notin @("x86_64", "aarch64")) {
    throw "Unsupported architecture: $Architecture (expected x86_64 or aarch64)"
}

$triple = Get-ZedWindowsTargetTriple -Arch $Architecture
$crossCompile = $Architecture -ne $hostArch
$repoRoot = Get-ZedRepoRoot
if (-not $InstallDir) {
    $InstallDir = Join-Path $env:LOCALAPPDATA "Programs\Zed"
}
$InstallDir = [System.IO.Path]::GetFullPath($InstallDir)
$backupDir = "$InstallDir.official-backup"
$zedDest = Join-Path $InstallDir "Zed.exe"
$cliDest = Join-Path $InstallDir "bin\zed.exe"
$helperDest = Join-Path $InstallDir "tools\auto_update_helper.exe"

function Get-ZedReleaseOutDir {
    $hostOut = Join-Path $repoRoot "target\release"
    $tripleOut = Join-Path $repoRoot "target\$triple\release"
    if ($crossCompile) {
        return $tripleOut
    }
    if (Test-Path -LiteralPath (Join-Path $hostOut "zed.exe")) {
        return $hostOut
    }
    if (Test-Path -LiteralPath (Join-Path $tripleOut "zed.exe")) {
        return $tripleOut
    }
    $hostOut
}

function Test-ZedInstallLayout {
    param([string]$Dir)

    Test-Path -LiteralPath (Join-Path $Dir "Zed.exe")
}

function Test-ZedFileUnlocked {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return $true
    }
    try {
        $stream = [System.IO.File]::Open(
            $Path,
            [System.IO.FileMode]::Open,
            [System.IO.FileAccess]::ReadWrite,
            [System.IO.FileShare]::None
        )
        $stream.Close()
        $true
    }
    catch {
        $false
    }
}

function Stop-ZedProcesses {
    $names = @("Zed", "zed")
    $procs = @(Get-Process -Name $names -ErrorAction SilentlyContinue)
    if ($procs.Count -eq 0) {
        Write-Host "No running Zed process."
        return
    }
    $ids = ($procs | ForEach-Object { $_.Id }) -join ", "
    if (-not $PSCmdlet.ShouldProcess("Zed processes ($ids)", "Stop")) {
        return
    }
    Write-Host "Stopping Zed processes: $ids"
    $procs | Stop-Process -Force
}

function Wait-ZedInstallUnlocked {
    param(
        [string[]]$Paths,
        [int]$TimeoutSeconds = 30
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ((Get-Date) -lt $deadline) {
        $locked = @($Paths | Where-Object { -not (Test-ZedFileUnlocked -Path $_) })
        if ($locked.Count -eq 0) {
            return
        }
        Start-Sleep -Milliseconds 400
    }
    $stillLocked = @($Paths | Where-Object { -not (Test-ZedFileUnlocked -Path $_) })
    if ($stillLocked.Count -gt 0) {
        throw "Timed out waiting for files to unlock: $($stillLocked -join ', ')"
    }
}

function Copy-ZedFileWithRetry {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination,
        [int]$Attempts = 8
    )

    $destDir = Split-Path $Destination -Parent
    if (-not (Test-Path -LiteralPath $destDir)) {
        if ($PSCmdlet.ShouldProcess($destDir, "Create directory")) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
    }

    if (-not $PSCmdlet.ShouldProcess($Destination, "Copy $Source")) {
        return
    }

    if (-not (Test-Path -LiteralPath $Source)) {
        throw "Source file not found: $Source"
    }

    $lastError = $null
    for ($i = 1; $i -le $Attempts; $i++) {
        try {
            Copy-Item -LiteralPath $Source -Destination $Destination -Force
            return
        }
        catch {
            $lastError = $_
            Write-Host "Copy attempt $i failed: $($_.Exception.Message)"
            Start-Sleep -Milliseconds (300 * $i)
        }
    }
    throw "Failed to copy $Source to $Destination : $($lastError.Exception.Message)"
}

function Copy-ZedInstallBackup {
    param([string]$Source, [string]$Destination)

    if (Test-Path -LiteralPath $Destination) {
        Write-Host "Backup already exists at $Destination"
        return
    }
    if (-not $PSCmdlet.ShouldProcess($Destination, "Backup $Source")) {
        return
    }
    Write-Host "Backing up $Source -> $Destination"
    Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
}

function Test-ZedWingetPinned {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        return $false
    }
    $previous = $PSNativeCommandUseErrorActionPreference
    $PSNativeCommandUseErrorActionPreference = $false
    try {
        $output = winget pin list 2>&1 | Out-String
        return [bool]($output -match 'ZedIndustries\.Zed')
    }
    finally {
        $PSNativeCommandUseErrorActionPreference = $previous
    }
}

function Test-ZedWingetInstalled {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        return $false
    }
    $previous = $PSNativeCommandUseErrorActionPreference
    $PSNativeCommandUseErrorActionPreference = $false
    try {
        $output = winget list -e --id ZedIndustries.Zed 2>&1 | Out-String
        return [bool]($output -match 'ZedIndustries\.Zed')
    }
    finally {
        $PSNativeCommandUseErrorActionPreference = $previous
    }
}

function Add-ZedWingetPin {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "winget not found; skipping pin."
        return
    }
    if (Test-ZedWingetPinned) {
        Write-Host "winget package ZedIndustries.Zed is already pinned."
        return
    }
    if (-not $PSCmdlet.ShouldProcess("ZedIndustries.Zed", "winget pin add")) {
        Write-Host "Would pin winget package ZedIndustries.Zed"
        return
    }
    Write-Host "Pinning winget package ZedIndustries.Zed"
    $previous = $PSNativeCommandUseErrorActionPreference
    $PSNativeCommandUseErrorActionPreference = $false
    try {
        winget pin add --id ZedIndustries.Zed --accept-source-agreements
        if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "winget pin add failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        $PSNativeCommandUseErrorActionPreference = $previous
    }
}

function Invoke-ZedDeployBuild {
    if ($crossCompile) {
        throw "Cross-compiling deploy from $hostArch to $Architecture is not supported. Build on the target machine."
    }

    Set-Location $repoRoot
    Initialize-ZedCargoPath
    Write-Host "==> env"
    Enter-ZedVsDevShell -Architecture $Architecture -HostArchitecture $hostArch

    $cmake = Find-ZedCmake
    if ($cmake) {
        $cmakeDir = Split-Path $cmake -Parent
        if ($env:Path -notlike "*$cmakeDir*") {
            $env:Path = "$cmakeDir;$env:Path"
        }
    }

    $env:ZED_RELEASE_CHANNEL = $Channel
    $env:RELEASE_CHANNEL = $Channel

    if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
        throw "rustup is not on PATH. Run script/windows.ps1 first."
    }
    rustup target add $triple
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "rustup target add $triple failed with exit code $LASTEXITCODE"
    }

    $jobCount = if ($Jobs -gt 0) { $Jobs } else { 2 }
    $buildArgs = @(
        "build", "--release", "--jobs", "$jobCount",
        "--package", "zed",
        "--package", "cli",
        "--package", "auto_update_helper"
    )
    Write-Host "Running: cargo $($buildArgs -join ' ') (channel $Channel)"
    cargo @buildArgs
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "cargo build failed with exit code $LASTEXITCODE"
    }
}

Set-Location $repoRoot
Initialize-ZedCargoPath

if (-not $Force -and -not (Test-ZedInstallLayout -Dir $InstallDir)) {
    throw "No Zed install found at $InstallDir (missing Zed.exe). Pass -Force to overlay anyway, or -InstallDir to choose another folder."
}

$doBackup = -not $NoBackup -and ($Backup -or -not (Test-Path -LiteralPath $backupDir))
$doPin = -not $NoPinWinget -and ($PinWinget -or (Test-ZedWingetInstalled))

Write-Host "Deploy overlay"
Write-Host "  channel:     $Channel"
Write-Host "  architecture: $Architecture"
Write-Host "  install dir: $InstallDir"
Write-Host "  build:       $shouldBuild"
Write-Host "  jobs:        $(if ($Jobs -gt 0) { $Jobs } else { 2 })"
Write-Host "  backup:      $doBackup"
Write-Host "  pin winget:  $doPin"
Write-Host "  launch:      $Launch"

$whatIf = [bool]$WhatIfPreference

if ($shouldBuild) {
    if ($whatIf) {
        Write-Host "Would build release packages zed, cli, auto_update_helper (channel $Channel)"
    }
    else {
        Invoke-ZedDeployBuild
    }
}

$outDir = Get-ZedReleaseOutDir
$zedSrc = Join-Path $outDir "zed.exe"
$cliSrc = Join-Path $outDir "cli.exe"
$helperSrc = Join-Path $outDir "auto_update_helper.exe"

$missing = @()
foreach ($pair in @(
        @{ Name = "zed.exe"; Path = $zedSrc },
        @{ Name = "cli.exe"; Path = $cliSrc },
        @{ Name = "auto_update_helper.exe"; Path = $helperSrc }
    )) {
    if (-not (Test-Path -LiteralPath $pair.Path)) {
        $missing += "$($pair.Name) ($($pair.Path))"
    }
}
if ($missing.Count -gt 0) {
    $message = "Missing $($missing -join ', '). Run without -NoBuild, or build those packages first."
    if ($whatIf) {
        Write-Host $message
    }
    else {
        throw $message
    }
}

Write-Host "Artifacts:"
Write-Host "  $zedSrc -> $zedDest"
Write-Host "  $cliSrc -> $cliDest"
Write-Host "  $helperSrc -> $helperDest"

if ($doBackup) {
    Copy-ZedInstallBackup -Source $InstallDir -Destination $backupDir
}

Stop-ZedProcesses
if (-not $whatIf) {
    Wait-ZedInstallUnlocked -Paths @($zedDest, $cliDest, $helperDest)
}

Copy-ZedFileWithRetry -Source $zedSrc -Destination $zedDest
Copy-ZedFileWithRetry -Source $cliSrc -Destination $cliDest
Copy-ZedFileWithRetry -Source $helperSrc -Destination $helperDest

if ($doPin) {
    Add-ZedWingetPin
}

if (-not $whatIf -and (Test-Path -LiteralPath $zedDest)) {
    $info = (Get-Item -LiteralPath $zedDest).VersionInfo
    Write-Host "Installed $($info.ProductName) $($info.ProductVersion)"
}

if ($Launch) {
    if ($PSCmdlet.ShouldProcess($zedDest, "Start")) {
        Start-Process -FilePath $zedDest
    }
    else {
        Write-Host "Would launch $zedDest"
    }
}

Write-Host "Windows deploy succeeded."
exit 0
