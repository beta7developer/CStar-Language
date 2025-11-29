# terminal.ps1
# Converted from terminal.sh (Bash) to PowerShell
# Fully implemented PowerShell equivalent of the original Bash script.
# Note: Some behaviors (like detecting MSYS/MINGW/CYGWIN) are approximated on native Windows PowerShell.

# Clear screen
Clear-Host

# Determine OS
$IsWindows = [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)
$IsLinux   = [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Linux)
$IsMacOS   = [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::OSX)

if ($IsMacOS) {
    $os_name = "Darwin"
} elseif ($IsLinux) {
    $os_name = "Linux"
} elseif ($IsWindows) {
    # The original Bash script checked for MINGW*, CYGWIN*, MSYS*.
    # When running in native PowerShell on Windows, treat it as the Windows-like environment.
    $os_name = "Windows"
} else {
    $os_name = "Unknown"
}

# Terminal / command strings
$ter_version = "CStar UCRT64 version 1.0.0 (Beta)"
$command = "ucrt --version"
$os_command = "ucrt --os -c"
$cls_command = "clear -a"
$compilerpkg = "pacman -S cstarc.exe --windows"
$compilerpkgmac = "pacman -S cstarcmacOS.out --macos"
$compilerpkgunix = "pacman -S cstarcUnix.out --unix"
$pacmanmgr = "pacman"
$pacmantag = "-S"
$cmd = "pacman -Syu"
$installcmd = "pacman -S cstdb.exe"
$filedebug = "cstdb.exe"
$yescommand = "yes"
$change_dir = "cd"
$version_command = "bash --version"
$git_version_command = "git --version"

# Helper: get file size safely (returns 0 if file doesn't exist)
function Get-FileSize([string]$path) {
    try {
        $item = Get-Item -LiteralPath $path -ErrorAction Stop
        return [int64]$item.Length
    } catch {
        return 0
    }
}

# File names (as used in original script)
$winFile = "cstarc.exe"
$macFile = "cstarcmacOS.out"
$unixFile = "cstarcUnix.out"
$debugFile = "cstdb.exe"

# Obtain sizes (if files are present in current directory)
$filesize = Get-FileSize $winFile
$filesizemac = Get-FileSize $macFile
$filesizeUnix = Get-FileSize $unixFile
$filesizedebug = Get-FileSize $debugFile

# Calculate KB/MB/GB (integers similar to Bash integer division)
function KB([int64]$bytes) { if ($bytes -le 0) { return 0 } else { return [math]::Floor($bytes / 1024) } }
function MB([int64]$bytes) { if ($bytes -le 0) { return 0 } else { return [math]::Floor($bytes / 1024 / 1024) } }
function GB([int64]$bytes) { if ($bytes -le 0) { return 0 } else { return [math]::Floor($bytes / 1024 / 1024 / 1024) } }

$kb = KB $filesize; $mb = MB $filesize; $gb = GB $filesize
$kbmac = KB $filesizemac; $mbmac = MB $filesizemac; $gbmac = GB $filesizemac
$kbunix = KB $filesizeUnix; $mbunix = MB $filesizeUnix; $gbunix = GB $filesizeUnix
$kbdebug = KB $filesizedebug; $mbdebug = MB $filesizedebug; $gbdebug = GB $filesizedebug

# Yes function: prints 'y' repeatedly until Ctrl+C
function Start-Yes {
    Write-Host "Press Ctrl+C to stop."
    try {
        while ($true) {
            Write-Host "y"
            Start-Sleep -Milliseconds 50
        }
    } catch [System.Exception] {
        # If user presses Ctrl+C, loop will be interrupted; just return
        return
    }
}

# Utility: read a single key (no Enter)
function Read-SingleKey {
    param(
        [bool]$Intercept = $true
    )
    # Build ReadKeyOptions safely instead of passing a string
    $opts = [System.Management.Automation.Host.ReadKeyOptions]::IncludeKeyDown
    if ($Intercept) { $opts = $opts -bor [System.Management.Automation.Host.ReadKeyOptions]::NoEcho }

    $keyInfo = $Host.UI.RawUI.ReadKey($opts)

    # Return printable character if available, otherwise empty string
    if ($null -ne $keyInfo.Character -and $keyInfo.Character -ne [char]0) {
        return $keyInfo.Character
    } else {
        return ""
    }
}

# Print copyright and header
Write-Host ""
Write-Host "Copyright" -NoNewline -ForegroundColor Red
Write-Host " (C) August 2025 Hoang Viet. All rights reserved."
Write-Host ""
Write-Host -ForegroundColor Blue "CStar" -NoNewline
Write-Host -ForegroundColor Magenta " UCRT64"
Write-Host "Detected OS: " -NoNewline
Write-Host $os_name -ForegroundColor Blue
Write-Host "Type: 'ucrt --help' for commands"
Write-Host ""

# Determine script path for restarting later
$scriptPath = $PSCommandPath
if ([string]::IsNullOrEmpty($scriptPath)) {
    $scriptPath = $MyInvocation.MyCommand.Path
}

# Detect PowerShell executable to use for restarting (pwsh if available, otherwise powershell)
$pwshCmd = Get-Command pwsh -ErrorAction SilentlyContinue
if ($pwshCmd) {
    $pwshPath = $pwshCmd.Source
} else {
    $powershellCmd = Get-Command powershell -ErrorAction SilentlyContinue
    if ($powershellCmd) {
        $pwshPath = $powershellCmd.Source
    } else {
        $pwshPath = $null
    }
}

# Main loop
while ($true) {
    Write-Host ""
    Start-Sleep -Seconds 1

    $user = $env:USERNAME
    if (-not $user) { $user = (whoami) -replace '\r|\n','' }
    $hostName = $env:COMPUTERNAME
    if (-not $hostName) { $hostName = (hostname) -replace '\r|\n','' }

    $cwd = (Get-Location).Path
    # Print prompt with colors: username@hostname UCRT64 PWD
    Write-Host -NoNewline -ForegroundColor Green ("{0}@{1}" -f $user, $hostName)
    Write-Host -NoNewline -ForegroundColor Magenta " UCRT64"
    Write-Host -NoNewline -ForegroundColor Yellow " $cwd"
    Write-Host ""

    $input = Read-Host ">>"

    # Normalize input (preserve case for things like package names; some comparisons are case-insensitive)
    $trimInput = $input.Trim()

    # Handle pacman -S cstarc.exe --windows (Windows/Msys-like)
    if (($trimInput -eq $compilerpkg) -and $IsWindows) {
        $sizeMB = "{0:N2}" -f ($filesize / 1MB)
        Write-Host "Size: $sizeMB MB. Continue: Press Y; Cancel: Press N"
        $k = Read-SingleKey
        Write-Host ""
        if ($k -eq 'Y' -or $k -eq 'y') {
            Write-Host "Installing $winFile..."
            $destDir = "D:/CStar/packages"
            if (-not (Test-Path -Path $destDir)) {
                try {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                } catch {
                    # Can't create directory; continue and let download fail if necessary
                }
            }
            $outPath = Join-Path $destDir $winFile
            try {
                Invoke-WebRequest -Uri "http://localhost:8443/public/files/$winFile" -OutFile $outPath -UseBasicParsing -ErrorAction Stop
                Write-Host "Installed $winFile"
            } catch {
                Write-Host "Installation failed." -ForegroundColor Red
            }
        } else {
            Write-Host "Installation cancelled."
        }
        continue
    }
    # If asking to install mac package but running in Windows-like environment
    elseif (($trimInput -eq $compilerpkgmac) -and $IsWindows) {
        Write-Host "bash: OS not compatible"
        continue
    }
    elseif (($trimInput -eq $compilerpkgunix) -and $IsWindows) {
        Write-Host "bash: OS almost/not compatible"
        continue
    }

    # If the command is for Windows package but running on Darwin
    if (($trimInput -eq $compilerpkg) -and $IsMacOS) {
        Write-Host "bash: OS not compatible"
        continue
    }

    # If installer for macOS on Darwin
    if (($trimInput -eq $compilerpkgmac) -and $IsMacOS) {
        $sizeMB = "{0:N2}" -f ($filesizemac / 1MB)
        Write-Host "Size: $sizeMB MB. Continue: Press Y; Cancel: Press N"
        $k = Read-SingleKey
        Write-Host ""
        if ($k -eq 'Y' -or $k -eq 'y') {
            Write-Host "Installing $macFile..."
            $destDir = "D:/CStar/packages"
            if (-not (Test-Path -Path $destDir)) {
                try { New-Item -ItemType Directory -Path $destDir -Force | Out-Null } catch {}
            }
            $outPath = Join-Path $destDir $macFile
            try {
                Invoke-WebRequest -Uri "http://localhost:8443/public/files/$macFile" -OutFile $outPath -UseBasicParsing -ErrorAction Stop
                Start-Sleep -Seconds 1
                Write-Host "Installed $macFile"
            } catch {
                Write-Host "Installation failed." -ForegroundColor Red
            }
        } else {
            Write-Host "Installation cancelled."
        }
        continue
    }

    # If unix package on Darwin
    if (($trimInput -eq $compilerpkgunix) -and $IsMacOS) {
        Write-Host "bash: OS almost compatible"
        continue
    }

    # Unix package on Linux
    if (($trimInput -eq $compilerpkgunix) -and $IsLinux) {
        $sizeMB = "{0:N2}" -f ($filesizeUnix / 1MB)
        Write-Host "Size: $sizeMB MB. Continue: Press Y; Cancel: Press N"
        $k = Read-SingleKey
        Write-Host ""
        if ($k -eq 'Y' -or $k -eq 'y') {
            Write-Host "Installing $unixFile..."
            $destDir = "D:/CStar/packages"
            if (-not (Test-Path -Path $destDir)) {
                try { New-Item -ItemType Directory -Path $destDir -Force | Out-Null } catch {}
            }
            $outPath = Join-Path $destDir $unixFile
            try {
                Invoke-WebRequest -Uri "http://localhost:8443/public/files/$unixFile" -OutFile $outPath -UseBasicParsing -ErrorAction Stop
                Start-Sleep -Seconds 1
                Write-Host "Installed $unixFile"
            } catch {
                Write-Host "Installation failed." -ForegroundColor Red
            }
        } else {
            Write-Host "Installation cancelled"
        }
        continue
    }

    # mac package on Linux
    if (($trimInput -eq $compilerpkgmac) -and $IsLinux) {
        Write-Host "bash: OS not compatible"
        continue
    }

    # windows package on Linux
    if (($trimInput -eq $compilerpkg) -and $IsLinux) {
        Write-Host "bash: OS not compatible"
        continue
    }

    # Exit command
    if ($trimInput -in @("E","e")) {
        Write-Host "Exiting UCRT64..."
        Start-Sleep -Seconds 2
        exit 0
    }

    # Restart command: re-run the script
    if ($trimInput -in @("R","r")) {
        Write-Host "Restarting UCRT64 with the latest update build..."
        Start-Sleep -Seconds 2
        if ($scriptPath) {
            try {
                if ($pwshPath) {
                    Start-Process -FilePath $pwshPath -ArgumentList "-NoProfile","-ExecutionPolicy","Bypass","-File",$scriptPath -WindowStyle Normal -ErrorAction Stop
                } else {
                    # Fallback to default powershell.exe (if present in PATH)
                    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -WindowStyle Normal -ErrorAction Stop
                }
                exit 0
            } catch {
                Write-Host "Cannot restart: $_" -ForegroundColor Yellow
            }
        } else {
            Write-Host "Cannot determine script path to restart." -ForegroundColor Yellow
        }
        continue
    }

    # Debugger installation
    if ($trimInput -eq $installcmd) {
        $sizeMB = "{0:N2}" -f ($filesizedebug / 1MB)
        Write-Host "Size: $sizeMB MB. Continue: Press Y; Cancel: Press N"
        $k = Read-SingleKey
        Write-Host ""
        if ($k -eq 'Y' -or $k -eq 'y') {
            Write-Host "Installing $filedebug..."
            $destDir = "D:/CStar/packages"
            if (-not (Test-Path -Path $destDir)) { try { New-Item -ItemType Directory -Path $destDir -Force | Out-Null } catch {} }
            $outPath = Join-Path $destDir $filedebug
            try {
                Invoke-WebRequest -Uri "https://localhost:8443/public/files/$filedebug" -OutFile $outPath -UseBasicParsing -ErrorAction Stop
                Start-Sleep -Seconds 1
                Write-Host "Installed $filedebug"
            } catch {
                Write-Host "Installation failed." -ForegroundColor Red
            }
        } else {
            Write-Host "Installation cancelled."
        }
        continue
    }

    # Pacman update
    if ($trimInput -eq $cmd) {
        Write-Host "Updating pacman (Package Manager)..."
        Start-Sleep -Seconds 1
        Write-Host "Updated finished, press [R]"
        $k = Read-SingleKey
        Write-Host ""
        if ($k -in @('R','r')) {
            Write-Host "Restarting UCRT64..."
            Start-Sleep -Seconds 1
            if ($scriptPath) {
                try {
                    if ($pwshPath) {
                        Start-Process -FilePath $pwshPath -ArgumentList "-NoProfile","-ExecutionPolicy","Bypass","-File",$scriptPath -WindowStyle Normal -ErrorAction Stop
                    } else {
                        Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile","-ExecutionPolicy","Bypass","-File",$scriptPath -WindowStyle Normal -ErrorAction Stop
                    }
                    exit 0
                } catch {
                    Write-Host "Cannot restart: $_" -ForegroundColor Yellow
                }
            } else {
                Write-Host "Cannot determine script path to restart." -ForegroundColor Yellow
            }
        }
        continue
    }

    # yes command
    if ($trimInput -eq $yescommand) {
        try {
            Start-Yes
        } catch {
            # continue loop
        }
        continue
    }

    # bash --version
    if ($trimInput -eq $version_command) {
        try {
            & bash --version
        } catch {
            Write-Host "bash not found or not available in PATH." -ForegroundColor Yellow
        }
        continue
    }

    # git --version
    if ($trimInput -eq $git_version_command) {
        try {
            & git --version
        } catch {
            Write-Host "git not found or not available in PATH." -ForegroundColor Yellow
        }
        continue
    }

    # change directory command: "cd"
    if ($trimInput -eq $change_dir) {
        $path = Read-Host "Enter in path"
        if ([string]::IsNullOrWhiteSpace($path)) {
            Write-Host -NoNewline
            Write-Host "bash: " -NoNewline -ForegroundColor Green
            Write-Host "no directory specified" -ForegroundColor Red
        } else {
            try {
                Set-Location -LiteralPath $path -ErrorAction Stop
            } catch {
                Write-Host "bash: cannot change directory to '$path'." -ForegroundColor Red
            }
        }
        continue
    }

    # pacman -S <pkg> pattern
    # We mimic the pattern: if input starts with "pacman -S "
    if ($trimInput -like "$pacmanmgr $pacmantag *") {
        $prefix = "$pacmanmgr $pacmantag "
        $pkgname = $trimInput.Substring($prefix.Length).Trim()
        if ([string]::IsNullOrWhiteSpace($pkgname)) {
            Write-Host "error: no targets specified (use -h for help)"
        } else {
            Write-Host "error: target not found: $pkgname"
        }
        continue
    }

    # Terminal version
    if ($trimInput -eq $command) {
        Write-Host $ter_version
        continue
    }

    # Clear screen
    if ($trimInput -eq $cls_command) {
        Clear-Host
        continue
    }

    # OS command
    if ($trimInput -eq $os_command) {
        Write-Host "OS: $os_name"
        continue
    }

    # Help command
    if ($trimInput -eq "ucrt --help") {
        Write-Host "CStar UCRT64 Installer Help"
        Write-Host ""
        Write-Host "Available commands:"
        Write-Host -NoNewline "  " ; Write-Host "pacman -S cstarc.exe --windows    Install Windows package" -ForegroundColor Yellow
        Write-Host "  pacman -S cstarcmacOS.out --macos Install macOS package"
        Write-Host "  pacman -S cstarcUnix.out --unix   Install Unix package"
        Write-Host "  ucrt --version                    Show terminal version"
        Write-Host "  ucrt --help                       Show this help message"
        Write-Host "  clear -a                          Clear the screen"
        Write-Host "  R / r                             Restart terminal"
        Write-Host "  E / e                             Exit terminal"
        Write-Host "  ucrt --os -c                      Check what OS are you on"
        Write-Host "  pacman -Syu                       Update the package manager (not Pac-Man, i am not coding it)"
        Write-Host "  yes                               Print 'y' repeatedly (Ctrl+C to stop)"
        Write-Host "  bash --version                    Prints the current bash version"
        Write-Host "  git --version                     Prints the current git version"
        continue
    }

    # Default: unknown command
    Write-Host -NoNewline -ForegroundColor Green "bash: "
    Write-Host -NoNewline $trimInput
    Write-Host " is not a cmdlet, function, or directory" -ForegroundColor Red
}
