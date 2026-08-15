#Requires -Version 5.1
[CmdletBinding()]
Param(
    [Parameter()][Alias('h')][switch]$Help,
    [Parameter()][switch]$Check,
    [Parameter()][switch]$InstallDeps
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

. "$PSScriptRoot/lib/windows-env.ps1"

function Show-WindowsHelp {
    Write-Output @"
Usage: windows.ps1 [-Check] [-InstallDeps] [-Help]

Install or verify Windows dependencies for building Zed from source.
Already-installed tools are skipped. Visual Studio / CMake are only
downloaded when -InstallDeps is passed.

Options:
  -Check         Report missing tools and exit non-zero if any are required and missing.
  -InstallDeps   Install missing CMake / VS Build Tools via winget (opt-in).
  -Help, -h      Show this help message.

After dependencies are in place, build with:
  script/build-windows.ps1
"@
}

function Test-ZedWinget {
    [bool](Get-Command winget -ErrorAction SilentlyContinue)
}

function Install-ZedWingetPackage {
    param(
        [Parameter(Mandatory = $true)][string]$Id,
        [string]$Override
    )

    if (-not (Test-ZedWinget)) {
        throw "winget was not found. Install '$Id' manually or install App Installer from the Microsoft Store."
    }

    Write-Host "Installing $Id via winget..."
    $wingetArgs = @(
        "install", "-e", "--id", $Id,
        "--accept-package-agreements", "--accept-source-agreements"
    )
    if ($Override) {
        $wingetArgs += @("--override", $Override)
    }
    & winget @wingetArgs
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne -1978335189) {
        # -1978335189 = already installed
        throw "winget install $Id failed with exit code $LASTEXITCODE"
    }
    Update-ZedUserPath
}

function Get-ZedVsInstaller {
    $candidates = @(
        (Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\setup.exe")
        (Join-Path $env:ProgramFiles "Microsoft Visual Studio\Installer\setup.exe")
    )
    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }
    $null
}

function Install-ZedMsvc {
    $addArgs = @()
    foreach ($component in $script:ZedInstallVsComponents) {
        $addArgs += @("--add", $component)
    }

    $existing = Get-ZedVsInstallPath -AnyInstall
    $installer = Get-ZedVsInstaller
    if ($existing -and $installer) {
        Write-Host "Modifying Visual Studio at $existing to add required C++ components..."
        $modifyArgs = @("modify", "--installPath", $existing, "--passive", "--wait", "--includeRecommended") + $addArgs
        & $installer @modifyArgs
        if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "Visual Studio Installer modify failed with exit code $LASTEXITCODE"
        }
        return
    }

    $override = (@("--wait", "--passive", "--includeRecommended") + $addArgs) -join " "
    Install-ZedWingetPackage -Id "Microsoft.VisualStudio.2022.BuildTools" -Override $override
}

function Set-ZedGitLongPaths {
    param([switch]$ReportOnly)

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "git was not found on PATH; skip enabling core.longpaths."
        return $false
    }

    $current = Invoke-ZedOptionalNative { git config --global --get core.longpaths 2>$null }
    if ($current -eq "true") {
        Write-Host "Git core.longpaths is already enabled."
        return $true
    }

    if ($ReportOnly) {
        Write-Host "Warning: git core.longpaths is not enabled."
        return $false
    }

    git config --global core.longpaths true
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        Write-Host "Warning: failed to set git core.longpaths."
        return $false
    }

    Write-Host "Enabled git core.longpaths."
    $true
}

function Set-ZedWindowsLongPaths {
    param([switch]$ReportOnly)

    $key = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
    try {
        $value = Get-ItemProperty -Path $key -Name "LongPathsEnabled" -ErrorAction SilentlyContinue
        if ($value -and $value.LongPathsEnabled -eq 1) {
            Write-Host "Windows LongPathsEnabled is already set."
            return $true
        }
    }
    catch {
        # Registry key missing or unreadable.
    }

    if ($ReportOnly -or -not (Test-ZedIsAdmin)) {
        Write-Host "Warning: Windows long paths are not enabled. Re-run this script from an elevated PowerShell, or set LongPathsEnabled as described in the Windows development docs. A reboot is required after enabling."
        return $false
    }

    New-ItemProperty -Path $key -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force | Out-Null
    Write-Host "Enabled Windows LongPathsEnabled. Reboot before relying on long paths."
    $true
}

function Install-ZedRust {
    $installScript = Join-Path $PSScriptRoot "install-rustup.ps1"
    & $installScript
    if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "script/install-rustup.ps1 failed with exit code $LASTEXITCODE"
    }

    Initialize-ZedCargoPath

    if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
        throw "rustup is not on PATH after installation. Open a new terminal and re-run this script."
    }

    Push-Location (Get-ZedRepoRoot)
    try {
        Write-Host "Ensuring the workspace Rust toolchain is installed..."
        rustup show
        if ($null -ne $LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "rustup show failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Test-ZedRust {
    Initialize-ZedCargoPath
    (Get-Command rustup -ErrorAction SilentlyContinue) -and (Get-Command cargo -ErrorAction SilentlyContinue)
}

function Resolve-ZedCmakePath {
    $cmake = Find-ZedCmake
    if ($cmake) {
        $cmakeDir = Split-Path $cmake -Parent
        if ($env:Path -notlike "*$cmakeDir*") {
            $env:Path = "$cmakeDir;$env:Path"
        }
    }
    $cmake
}

Set-Location (Get-ZedRepoRoot)

if ($Help) {
    Show-WindowsHelp
    exit 0
}

$problems = @()

Write-Host "==> git long paths"
Set-ZedGitLongPaths -ReportOnly:$Check | Out-Null

Write-Host "==> Windows long paths"
Set-ZedWindowsLongPaths -ReportOnly:$Check | Out-Null

Write-Host "==> Rust"
if (Test-ZedRust) {
    Write-Host "rustup and cargo are on PATH."
    if (-not $Check) {
        Install-ZedRust
    }
}
elseif ($Check) {
    $problems += "Rust (rustup/cargo) is not installed."
}
else {
    Install-ZedRust
}

Write-Host "==> CMake"
$cmake = Resolve-ZedCmakePath
if ($cmake) {
    Write-Host "CMake found: $cmake"
}
elseif ($Check) {
    $problems += "CMake is not installed."
}
elseif ($InstallDeps) {
    Install-ZedWingetPackage -Id "Kitware.CMake"
    $cmake = Resolve-ZedCmakePath
    if (-not $cmake) {
        $problems += "CMake is still missing after winget install. Open a new terminal or add CMake to PATH."
    }
}
else {
    $problems += "CMake is not installed. Re-run with -InstallDeps or install CMake from https://cmake.org/download."
}

Write-Host "==> MSVC"
$missingVs = @(Get-ZedMissingVsComponents)
if ($missingVs.Count -eq 0) {
    Write-Host "Required Visual Studio C++ components are installed."
}
elseif ($Check) {
    Write-Host "Missing Visual Studio components: $($missingVs -join ', ')"
    $problems += "Missing Visual Studio components: $($missingVs -join ', ')"
}
elseif ($InstallDeps) {
    Install-ZedMsvc
    $missingVs = @(Get-ZedMissingVsComponents)
    if ($missingVs.Count -gt 0) {
        $problems += "Still missing Visual Studio components after install: $($missingVs -join ', ')"
    }
}
else {
    $problems += "Missing Visual Studio components: $($missingVs -join ', '). Re-run with -InstallDeps or install Build Tools as described in docs/src/development/windows.md."
}

Write-Host "==> Windows SDK"
if (Test-ZedWindowsSdk) {
    $latest = (Get-ZedWindowsSdkVersions | Sort-Object -Descending | Select-Object -First 1)
    Write-Host "Windows SDK $latest found (minimum $($script:ZedMinWindowsSdk))."
}
elseif ($Check) {
    $problems += "Windows SDK >= $($script:ZedMinWindowsSdk) is not installed."
}
elseif ($InstallDeps) {
    Write-Host "Windows SDK is missing; installing Visual Studio components that include Windows 11 SDK 26100."
    Install-ZedMsvc
    if (-not (Test-ZedWindowsSdk)) {
        $problems += "Windows SDK >= $($script:ZedMinWindowsSdk) is still missing. Install it from https://developer.microsoft.com/windows/downloads/windows-sdk/."
    }
}
else {
    $problems += "Windows SDK >= $($script:ZedMinWindowsSdk) is not installed. Re-run with -InstallDeps or install the SDK from https://developer.microsoft.com/windows/downloads/windows-sdk/."
}

if ($problems.Count -gt 0) {
    Write-Host ""
    Write-Host "Missing dependencies:"
    foreach ($problem in $problems) {
        Write-Host "  - $problem"
    }
    if (-not $Check -and -not $InstallDeps) {
        Write-Host ""
        Write-Host "Fix manually, or re-run: script/windows.ps1 -InstallDeps"
    }
    exit 1
}

Write-Host ""
Write-Host "Windows build dependencies are ready."
if (-not $Check) {
    Write-Host "Next: script/build-windows.ps1"
    Write-Host "  Debug:   script/build-windows.ps1"
    Write-Host "  Release: script/build-windows.ps1 -Release"
    Write-Host "  Resume:  script/build-windows.ps1 -Resume"
}
exit 0
