# wslterminal.ps1
# CStar CSLE Terminal - PowerShell Version (Corrected)
Clear-Host

# Determine OS reliably
if ([System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)) {
    $os_name = "Windows"
} elseif ([System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::OSX)) {
    $os_name = "Darwin"
} elseif ([System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Linux)) {
    $os_name = "Linux"
} else {
    $os_name = "Unknown"
}

$os_command   = "wsl --os -c"
$ter_version  = "CStar CSLE version 1.0.0 (Beta)"
$command      = "wsl --version"
$cls_command  = "clear -a"

# Utility: safe single-key reader
function Read-KeyChar {
    $opts = [System.Management.Automation.Host.ReadKeyOptions]::IncludeKeyDown -bor [System.Management.Automation.Host.ReadKeyOptions]::NoEcho
    $key = $host.UI.RawUI.ReadKey($opts)
    return [string]$key.Character
}

# Function to get file size (bytes) or 0
function Get-FileSize {
    param([string]$FilePath)
    try {
        if (Test-Path $FilePath) {
            return (Get-Item $FilePath).Length
        }
    } catch { }
    return 0
}

# File size checks
$filesize      = Get-FileSize "cstarc.exe"
$filesizemac   = Get-FileSize "cstarcmacOS.out"
$filesizeUnix  = Get-FileSize "cstarcUnix.out"
$filesizedebug = Get-FileSize "cstdb.exe"

# Size helpers (integers)
$kb      = [math]::Floor($filesize / 1024.0)
$mb      = [math]::Floor($filesize / 1024.0 / 1024.0)
$gb      = [math]::Floor($filesize / 1024.0 / 1024.0 / 1024.0)

$kbmac   = [math]::Floor($filesizemac / 1024.0)
$mbmac   = [math]::Floor($filesizemac / 1024.0 / 1024.0)
$gbmac   = [math]::Floor($filesizemac / 1024.0 / 1024.0 / 1024.0)

$kbunix  = [math]::Floor($filesizeUnix / 1024.0)
$mbunix  = [math]::Floor($filesizeUnix / 1024.0 / 1024.0)
$gbunix  = [math]::Floor($filesizeUnix / 1024.0 / 1024.0 / 1024.0)

$kbdebug = [math]::Floor($filesizedebug / 1024.0)
$mbdebug = [math]::Floor($filesizedebug / 1024.0 / 1024.0)
$gbdebug = [math]::Floor($filesizedebug / 1024.0 / 1024.0 / 1024.0)

# Commands and constants
$compilerpkg    = "pacman -S cstarc.exe --windows"
$compilerpkgmac = "pacman -S cstarcmacOS.out --macos"
$compilerpkgunix= "pacman -S cstarcUnix.out --unix"

$pacmanmgr      = "pacman"
$pacmantag      = "-S"
$pacmanpkg      = ""
$found          = $false

$cmd            = "pacman -Syu"
$installcmd     = "pacman -S cstdb.exe"
$filedebug      = "cstdb.exe"
$yescommand     = "yes"
$version_command= "pwsh --version"

# Determine installation path based on OS
if ($os_name -eq "Windows") {
    $installPath = "D:\CStar\packages"
} else {
    $installPath = Join-Path $HOME "CStar/packages"
}

# Helper: continuous 'yes' output (Ctrl+C to stop)
function Invoke-YesFunction {
    try {
        while ($true) {
            Write-Host "y"
            Start-Sleep -Milliseconds 50
        }
    } catch {
        # User pressed Ctrl+C
    }
}

# Helper: current user / host / cwd
function Get-CurrentUser { return [Environment]::UserName }
function Get-ComputerHostName { 
    if ($os_name -eq "Windows") {
        return $env:COMPUTERNAME
    } else {
        return hostname
    }
}
function Get-CurrentDirectory { return (Get-Location).Path }

# Script path for restart attempts
$scriptPath = $PSCommandPath
if ([string]::IsNullOrEmpty($scriptPath)) { $scriptPath = $MyInvocation.MyCommand.Path }

# Header
Write-Host ""
Write-Host "`e[1;31mCopyright`e[0m (C) August 2025 Hoang Viet. All rights reserved."
Write-Host ""
Write-Host "`e[1;34mCStar`e[0m `e[35mCSLE`e[0m"
Write-Host "`e[0mDetected OS: `e[1;34m$os_name`e[0m"
Write-Host "`e[1;34mCStar`e[0m `e[35mLinux Environment`e[0m"
Write-Host "`e[0mType: `e[1;33m'wsl`e[0m `e[1;30m--help`e[0m' for commands"
Write-Host ""
Start-Sleep -Seconds 1

# Main loop
while ($true) {
    $user = Get-CurrentUser
    $hostname = Get-ComputerHostName
    $pwd = Get-CurrentDirectory

    $prompt = "`e[1;32m$user@$hostname`e[0m:`e[0;34m$pwd`e[0m$ "
    $input = Read-Host $prompt

    # Installation paths and flows
    if ($input -eq $compilerpkg -and $os_name -eq "Windows") {
        $sizeInMB = [math]::Round($filesize / 1024.0 / 1024.0, 2)
        Write-Host "Size: $sizeInMB MB. Continue: Press Y; Cancel: Press N"
        $key = Read-KeyChar
        if ($key -in @('Y','y')) {
            Write-Host "Installing cstarc.exe..."
            try {
                New-Item -ItemType Directory -Path $installPath -Force | Out-Null
                Invoke-WebRequest -Uri "https://localhost:8443/public/files/cstarc.exe" -OutFile "$installPath\cstarc.exe" -SkipCertificateCheck -UseBasicParsing
                Start-Sleep -Seconds 1
                Write-Host "Installed cstarc.exe"
            } catch {
                Write-Host "`e[1;31mInstallation failed: $($_.Exception.Message)`e[0m"
            }
        } else {
            Write-Host "Installation cancelled."
        }
    }
    elseif ($input -eq $compilerpkgmac -and $os_name -eq "Windows") {
        Write-Host "bash: OS not compatible"
    }
    elseif ($input -eq $compilerpkgunix -and $os_name -eq "Windows") {
        Write-Host "bash: OS almost/not compatible"
    }
    elseif ($input -eq $compilerpkg -and $os_name -eq "Darwin") {
        Write-Host "bash: OS not compatible"
    }
    elseif ($input -eq $compilerpkgmac -and $os_name -eq "Darwin") {
        $sizeInMB = [math]::Round($filesizemac / 1024.0 / 1024.0, 2)
        Write-Host "Size: $sizeInMB MB. Continue: Press Y; Cancel: Press N"
        $key = Read-KeyChar
        if ($key -in @('Y','y')) {
            Write-Host "Installing cstarcmacOS.out..."
            try {
                New-Item -ItemType Directory -Path $installPath -Force | Out-Null
                Invoke-WebRequest -Uri "https://localhost:8443/public/files/cstarcmacOS.out" -OutFile "$installPath/cstarcmacOS.out" -SkipCertificateCheck -UseBasicParsing
                Start-Sleep -Seconds 1
                Write-Host "Installed cstarcmacOS.out"
            } catch {
                Write-Host "`e[1;31mInstallation failed: $($_.Exception.Message)`e[0m"
            }
        } else {
            Write-Host "Installation cancelled."
        }
    }
    elseif ($input -eq $compilerpkgunix -and $os_name -eq "Darwin") {
        Write-Host "bash: OS almost compatible"
    }
    elseif ($input -eq $compilerpkgunix -and $os_name -eq "Linux") {
        $sizeInMB = [math]::Round($filesizeUnix / 1024.0 / 1024.0, 2)
        Write-Host "Size: $sizeInMB MB. Continue: Press Y; Cancel: Press N"
        $key = Read-KeyChar
        if ($key -in @('Y','y')) {
            Write-Host "Installing cstarcUnix.out..."
            try {
                New-Item -ItemType Directory -Path $installPath -Force | Out-Null
                Invoke-WebRequest -Uri "https://localhost:8443/public/files/cstarcUnix.out" -OutFile "$installPath/cstarcUnix.out" -SkipCertificateCheck -UseBasicParsing
                Start-Sleep -Seconds 1
                Write-Host "Installed cstarcUnix.out"
            } catch {
                Write-Host "`e[1;31mInstallation failed: $($_.Exception.Message)`e[0m"
            }
        } else {
            Write-Host "Installation cancelled."
        }
    }
    elseif ($input -eq $compilerpkgmac -and $os_name -eq "Linux") {
        Write-Host "bash: OS not compatible"
    }
    elseif ($input -eq $compilerpkg -and $os_name -eq "Linux") {
        Write-Host "bash: OS not compatible"
    }
    elseif ($input -in @("E","e")) {
        Write-Host "Exiting CSLE..."
        Start-Sleep -Seconds 2
        exit 0
    }
    elseif ($input -in @("R","r")) {
        Write-Host "Restarting CSLE with the latest update build..."
        Start-Sleep -Seconds 2
        if ($scriptPath) { 
            & $scriptPath 
        } else { 
            Write-Host "Cannot determine script path to restart." 
        }
    }
    elseif ($input -eq $installcmd) {
        $sizeInMB = [math]::Round($filesizedebug / 1024.0 / 1024.0, 2)
        Write-Host "Size: $sizeInMB MB. Continue: Press Y; Cancel: Press N"
        $key = Read-KeyChar
        if ($key -in @('Y','y')) {
            Write-Host "Installing $filedebug..."
            try {
                New-Item -ItemType Directory -Path $installPath -Force | Out-Null
                Invoke-WebRequest -Uri "https://localhost:8443/public/files/cstdb.exe" -OutFile "$installPath\cstdb.exe" -SkipCertificateCheck -UseBasicParsing
                Start-Sleep -Seconds 1
                Write-Host "Installed $filedebug"
            } catch {
                Write-Host "`e[1;31mInstallation failed: $($_.Exception.Message)`e[0m"
            }
        } else {
            Write-Host "Installation cancelled."
        }
    }
    elseif ($input -eq $cmd) {
        Write-Host "Updating pacman (Package Manager)..."
        Start-Sleep -Seconds 1
        Write-Host "Update finished, press [R]"
        $key = Read-KeyChar
        if ($key -in @('R','r')) {
            Write-Host "Restarting UCRT64..."
            if ($scriptPath) { 
                & $scriptPath 
            } else { 
                Write-Host "Cannot determine script path to restart." 
            }
        }
    }
    elseif ($input -eq $yescommand) {
        Invoke-YesFunction
    }
    elseif ($input -eq $version_command) {
        $PSVersionTable.PSVersion
    }
    elseif ($input -match "^pacman -S ") {
        $pkgname = $input -replace "^pacman -S ", ""
        if ([string]::IsNullOrWhiteSpace($pkgname)) {
            Write-Host "error: no targets specified (use -h for help)"
        } else {
            Write-Host "error: target not found: $pkgname"
        }
    }
    elseif ($input -eq $command) {
        Write-Host $ter_version
    }
    elseif ($input -eq $cls_command) {
        Clear-Host
    }
    elseif ($input -eq $os_command) {
        Write-Host "OS: $os_name"
    }
    elseif ($input -eq "wsl --help") {
        Write-Host "CStar CSLE Installer Help"
        Write-Host ""
        Write-Host "Available commands:"
        Write-Host "  `e[38;5;216mpacman -S cstarc.exe --windows`e[0m    Install Windows package"
        Write-Host "  `e[38;5;216mpacman -S cstarcmacOS.out --macos`e[0m Install macOS package"
        Write-Host "  `e[38;5;216mpacman -S cstarcUnix.out --unix`e[0m   Install Unix package"
        Write-Host "  `e[38;5;216mwsl --version`e[0m                     Show terminal version"
        Write-Host "  `e[38;5;216mwsl --help`e[0m                        Show this help message"
        Write-Host "  `e[38;5;216mclear -a`e[0m                          Clear the screen"
        Write-Host "  `e[38;5;216mR / r`e[0m                             Restart terminal"
        Write-Host "  `e[38;5;216mE / e`e[0m                             Exit terminal"
        Write-Host "  `e[38;5;216mwsl --os -c`e[0m                       Check what OS are you on"
        Write-Host "  `e[38;5;216mpacman -Syu`e[0m                       Update the package manager"
        Write-Host "  `e[38;5;216myes`e[0m                               Print 'y' repeatedly (Ctrl+C to stop)"
        Write-Host "  `e[38;5;216mpwsh --version`e[0m                    Prints the current PowerShell version"
    }
    else {
        Write-Host "`e[1;32mPowerShell: `e[0m$input `e[1;31mis not a cmdlet, function, or directory`e[0m"
    }
}
# -----