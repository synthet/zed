#Requires -Version 5.1
[CmdletBinding()]
Param(
    [Parameter()][Alias('h')][switch]$Help,
    [Parameter()][switch]$Resume,
    [Parameter()][switch]$FromStart,
    [Parameter()][switch]$Clean,
    [Parameter()][switch]$Release,
    [Parameter()][switch]$Run,
    [Parameter()][Alias('a')][string]$Architecture
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

. "$PSScriptRoot/lib/windows-env.ps1"

function Show-BuildWindowsHelp {
    Write-Output @"
Usage: build-windows.ps1 [-Resume] [-FromStart] [-Clean] [-Release] [-Run] [-Architecture <arch>] [-Help]

Build Zed from source on Windows. Re-running this script after a crash, OOM,
or closed terminal continues the previous attempt: MSVC is re-initialized,
completed setup steps are skipped, and cargo incremental compilation resumes.
The script never runs cargo clean unless -Clean is passed.

Options:
  -Resume              Skip completed setup steps and continue (default when a
                       state file already exists).
  -FromStart           Ignore saved setup checkpoints. Does not clean cargo artifacts.
  -Clean               Run cargo clean, reset checkpoints, then build.
  -Release             Build with --release (default is a debug build).
  -Run                 Run Zed after a successful build.
  -Architecture, -a    x86_64 or aarch64 (default: host architecture).
  -Help, -h            Show this help message.

Examples:
  script/build-windows.ps1
  script/build-windows.ps1 -Release
  script/build-windows.ps1 -Resume
  script/build-windows.ps1 -Run
"@
}

if ($Help) {
    Show-BuildWindowsHelp
    exit 0
}

if ($Resume -and $FromStart) {
    throw "Use only one of -Resume and -FromStart."
}
if ($Clean -and $Resume) {
    throw "Use only one of -Clean and -Resume. -Clean resets checkpoints."
}

$hostArch = Get-ZedWindowsArch
if (-not $Architecture) {
    $Architecture = $hostArch
}
if ($Architecture -notin @("x86_64", "aarch64")) {
    throw "Unsupported architecture: $Architecture (expected x86_64 or aarch64)"
}

$profileName = if ($Release) { "release" } else { "debug" }
$triple = Get-ZedWindowsTargetTriple -Arch $Architecture
$crossCompile = $Architecture -ne $hostArch
$statePath = Get-ZedBuildWindowsStatePath
$stateExists = Test-Path -LiteralPath $statePath

if ($Clean) {
    $useResume = $false
    $ignoreState = $true
}
elseif ($FromStart) {
    $useResume = $false
    $ignoreState = $true
}
elseif ($Resume) {
    $useResume = $true
    $ignoreState = $false
}
else {
    $useResume = $stateExists
    $ignoreState = $false
}

Set-Location (Get-ZedRepoRoot)
Initialize-ZedCargoPath

if ($Clean) {
    Write-Host "Cleaning cargo artifacts and build checkpoints..."
    if (Get-Command cargo -ErrorAction SilentlyContinue) {
        cargo clean
        if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "cargo clean failed with exit code $LASTEXITCODE"
        }
    }
    $state = Reset-ZedBuildWindowsState -Profile $profileName -Architecture $Architecture
}
else {
    $state = Get-ZedBuildWindowsState -Profile $profileName -Architecture $Architecture -IgnoreExisting:$ignoreState
}

if ($useResume) {
    Write-Host "Resuming Windows build ($profileName / $Architecture)."
    if ($state.failedStep) {
        Write-Host "Last failed step: $($state.failedStep) ($($state.lastError))"
    }
}
else {
    Write-Host "Starting Windows build ($profileName / $Architecture)."
}

Write-Host "==> env"
Enter-ZedVsDevShell -Architecture $Architecture -HostArchitecture $hostArch

$cmake = Find-ZedCmake
if ($cmake) {
    $cmakeDir = Split-Path $cmake -Parent
    if ($env:Path -notlike "*$cmakeDir*") {
        $env:Path = "$cmakeDir;$env:Path"
    }
}

$windowsScript = Join-Path $PSScriptRoot "windows.ps1"

Invoke-ZedBuildStep -Name "check_deps" -State $state -Resume:$useResume -SkipIf {
    [bool](Get-Command cl -ErrorAction SilentlyContinue)
} -Action {
    & $windowsScript -Check
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "script/windows.ps1 -Check failed. Fix the missing tools, or run script/windows.ps1 -InstallDeps."
    }
}

Invoke-ZedBuildStep -Name "toolchain" -State $state -Resume:$useResume -Action {
    if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
        throw "rustup is not on PATH. Run script/windows.ps1 first."
    }
    rustup target add $triple
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "rustup target add $triple failed with exit code $LASTEXITCODE"
    }
}

Invoke-ZedBuildStep -Name "fetch" -State $state -Resume:$useResume -Action {
    $fetchArgs = @("fetch")
    if ($crossCompile) {
        $fetchArgs += @("--target", $triple)
    }
    cargo @fetchArgs
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "cargo fetch failed with exit code $LASTEXITCODE"
    }
}

function Get-ZedCargoBuildArgs {
    $cargoArgs = @("--package", "zed")
    if ($Release) {
        $cargoArgs += "--release"
    }
    if ($crossCompile) {
        $cargoArgs += @("--target", $triple)
    }
    $cargoArgs
}

Invoke-ZedBuildStep -Name "build" -State $state -Always -Action {
    $buildArgs = @("build") + (Get-ZedCargoBuildArgs)
    Write-Host "Running: cargo $($buildArgs -join ' ')"
    cargo @buildArgs
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "cargo build failed with exit code $LASTEXITCODE"
    }
}

if ($Run) {
    if ($crossCompile) {
        throw "-Run is not supported when cross-compiling to $Architecture from $hostArch."
    }
    $runArgs = @("run") + (Get-ZedCargoBuildArgs)
    Write-Host "Running: cargo $($runArgs -join ' ')"
    cargo @runArgs
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "cargo run failed with exit code $LASTEXITCODE"
    }
}

Write-Host "Windows build succeeded ($profileName / $Architecture)."
exit 0
