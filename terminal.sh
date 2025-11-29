#!/bin/bash

# Clears the screen
clear

# OS checking
os_name="$(uname -s)"
os_command="ucrt --os -c"

# Terminal version
ter_version="CStar UCRT64 version 1.0.0 (Beta)"
command="ucrt --version"

# Clear command
cls_command="clear -a"

# File size
if [[ "$os_name" == "Darwin" ]]; then
    filesize=$(stat -f%z "cstarc.exe" 2>/dev/null)
    filesizemac=$(stat -f%z "cstarcmacOS.out" 2>/dev/null)
    filesizeUnix=$(stat -f%z "cstarcUnix.out" 2>/dev/null)
else
    filesize=$(stat -c%s "cstarc.exe" 2>/dev/null)
    filesizemac=$(stat -c%s "cstarcmacOS.out" 2>/dev/null)
    filesizeUnix=$(stat -c%s "cstarcUnix.out" 2>/dev/null)
    filesizedebug=$(stat -c%s "cstdb.exe" 2>/dev/null)
fi

# Data filter
kb=$((filesize / 1024))
mb=$((filesize / 1024 / 1024))
gb=$((filesize / 1024 / 1024 / 1024))

kbmac=$((filesizemac / 1024))
mbmac=$((filesizemac / 1024 / 1024))
gbmac=$((filesizemac / 1024 / 1024 / 1024))

kbunix=$((filesizeUnix / 1024))
mbunix=$((filesizeUnix / 1024 / 1024))
gbunix=$((filesizeUnix / 1024 / 1024 / 1024))

kbdebug=$((filesizedebug / 1024))
mbdebug=$((filesizedebug / 1024 / 1024))
gbdebug=$((filesizedebug / 1024 / 1024 / 1024))

# Commands
compilerpkg="pacman -S cstarc.exe --windows"
compilerpkgmac="pacman -S cstarcmacOS.out --macos"
compilerpkgunix="pacman -S cstarcUnix.out --unix"

pacmanmgr="pacman"
pacmantag="-S"
pacmanpkg=""
found=false

# Pacman updating
cmd="pacman -Syu"

# Debugger installation
installcmd="pacman -S cstdb.exe"
filedebug="cstdb.exe"

yesdata=""
yescommand="yes"

change_dir="cd"

# Bash version command
version_command="bash --version"
git_version_command="git --version"

# Function for the yes command
yes_function() {
    trap 'echo ""; return' INT
    while true; do
        echo "y"
    done
}

# Copyright and terminal name message
echo ""
echo -e "\033[1;31mCopyright\033[0m (C) August 2025 Hoang Viet. All rights reserved."
echo ""
echo -e "\033[1;34mCStar\033[0m \x1B[35mUCRT64\x1B[0m"
echo -e "Detected OS: \033[1;34m$os_name\033[0m"
echo -e "Type: \033[1;33m'ucrt\033[0m \033[1;30m--help\033[0m' for commands"

# Looped input
while true; do
    echo ""
    sleep 1
    echo -e "\033[1;32m$(whoami)@$(hostname)\033[0m \x1B[1;35mUCRT64\x1B[0m\033[0;33m" $PWD "\033[0m"
    read -p ">> " input

    # Matching units
    if [[ "$input" == "$compilerpkg" ]] && [[ "$os_name" == MINGW* || "$os_name" == CYGWIN* || "$os_name" == MSYS* ]]; then
        echo "Size: $(awk "BEGIN {printf \"%.2f\", $filesize/1024/1024}") MB. Continue: Press Y; Cancel: Press N"
        read -n 1 -s key
        if [[ "$key" == "Y" || "$key" == "y" ]]; then
            echo "Installing cstarc.exe..."
            wget -P "D:/CStar/packages" "http://localhost:8443/public/files/cstarc.exe"
            sleep 1
            if [[ $? -eq 0 ]]; then
                echo "Installed cstarc.exe"
            else
                echo "\033[1;31mInstallation failed.\033[0m"
            fi
        else
            echo "Installation cancelled."
        fi
    elif [[ "$input" == "$compilerpkgmac" ]] && [[ "$os_name" == MINGW* || "$os_name" == CYGWIN* || "$os_name" == MSYS* ]]; then
        echo "bash: OS not compatible"

    elif [[ "$input" == "$compilerpkgunix" ]] && [[ "$os_name" == MINGW* || "$os_name" == CYGWIN* || "$os_name" == MSYS* ]]; then
        echo "bash: OS almost/not compatible"

    elif [[ "$input" == "$compilerpkg" ]] && [[ "$os_name" == "Darwin" ]]; then
        echo "bash: OS not compatible"

    elif [[ "$input" == "$compilerpkgmac" ]] && [[ "$os_name" == "Darwin" ]]; then
        echo "Size: $(awk "BEGIN {printf \"%.2f\", $filesizemac/1024/1024}") MB. Continue: Press Y; Cancel: Press N"
        read -n 1 -s key
        if [[ "$key" == "Y" ]]; then
            echo "Installing cstarcmacOS.out..."
            wget -P "D:/CStar/packages" "http://localhost:8443/public/files/cstarcmacOS.out"
            sleep 1
            echo "Installed cstarcmacOS.out"
        else
            echo "Installation cancelled."
        fi

    elif [[ "$input" == "$compilerpkgunix" ]] && [[ "$os_name" == "Darwin" ]]; then
        echo "bash: OS almost compatible"

    elif [[ "$input" == "$compilerpkgunix" ]] && [[ "$os_name" == "Linux" ]]; then
        echo "Size: $(awk "BEGIN {printf \"%.2f\", $filesizeunix/1024/1024}") MB. Continue: Press Y; Cancel: Press N"
        read -n 1 -s key
        if [[ "$key" == "Y" ]]; then
            echo "Installing cstarcUnix.out..."
            wget -P "D:/CStar/packages" "http://localhost:8443/public/files/cstarcUnix.out"
            sleep 1
            echo "Installed cstarcUnix.out"
        else
            echo "Installation cancelled"
        fi
    
    elif [[ "$input" == "$compilerpkgmac" ]] && [[ "$os_name" == "Linux" ]]; then
        echo "bash: OS not compatible"

    elif [[ "$input" == "$compilerpkg" ]] && [[ "$os_name" == "Linux" ]]; then
        echo "bash: OS not compatible"

    elif [[ "$input" == "E" || "$input" == "e" ]]; then
        echo "Exiting UCRT64..."
        sleep 2
        exit 0

    elif [[ "$input" == "R" || "$input" == "r" ]]; then
        echo "Restarting UCRT64 with the latest update build..."
        sleep 2
        exec "$(realpath "$0")"

    elif [[ "$input" == "$installcmd" ]]; then
        echo "Size: $(awk "BEGIN {printf \"%.2f\", $filesizedebug/1024/1024}") MB. Continue: Press Y; Cancel: Press N"
        read -n 1 -s key
        if [[ "$key" == "Y" || "$key" == "y" ]]; then
            echo "Installing $filedebug..."
            wget -P "D:/CStar/packages" "https://localhost:8443/public/files/cstdb.exe"
            sleep 1
            echo "Installed $filedebug"
        fi

    elif [[ "$input" == "$cmd" ]]; then
        echo "Updating pacman (Package Manager)..."
        sleep 1
        echo "Updated finished, press [R]"
        read -n 1 -s key
        if [[ "$key" == "R" || "$key" == "r" ]]; then
            echo "Restarting UCRT64..."
            exec "$(realpath "$0")"
        fi

    elif [[ "$input" == "$yescommand" ]]; then
        yes_function

    elif [[ "$input" == "$version_command" ]]; then
        bash --version

    elif [[ "$input" == "$git_version_command" ]]; then
        git --version

    elif [[ "$input" == "$change_dir" ]]; then
        read -p "Enter in path: " path
        cd "$path" 
        if [[ "$path" == "" ]]; then
            echo -e "\033[1;32mbash: \033[0m\033[1;31mno directory specified\033[0m"
        fi

    elif [[ "$input" == "$pacmanmgr $pacmantag "* ]]; then
        pkgname="${input#"$pacmanmgr $pacmantag "}"
        if [[ -z "$pkgname" || "$pkgname" =~ ^[[:space:]]*$ ]]; then
            echo "error: no targets specified (use -h for help)"
        else
            echo "error: target not found: $pkgname"
        fi

    elif [[ "$input" == "$command" ]]; then
        echo "$ter_version"

    elif [[ "$input" == "$cls_command" ]]; then
        clear

    elif [[ "$input" == "$os_command" ]]; then
        echo "OS: $os_name"

    elif [[ "$input" == "ucrt --help" ]]; then
        echo "CStar UCRT64 Installer Help"
        echo ""
        echo "Available commands:"
        echo -e "  \033[38;5;216mpacman -S cstarc.exe --windows    Install Windows package"
        echo "  pacman -S cstarcmacOS.out --macos Install macOS package"
        echo "  pacman -S cstarcUnix.out --unix   Install Unix package"
        echo "  ucrt --version                    Show terminal version"
        echo "  ucrt --help                       Show this help message"
        echo "  clear -a                          Clear the screen"
        echo "  R / r                             Restart terminal"
        echo "  E / e                             Exit terminal"
        echo "  ucrt --os -c                      Check what OS are you on"
        echo "  pacman -Syu                       Update the package manager (not Pac-Man, i am not coding it)"
        echo "  yes                               Print 'y' repeatedly (Ctrl+C to stop)"
        echo -e "  bash --version                    Prints the current bash version"
        echo -e "  git --version                     Prints the current git version\033[0m"

    else
        echo -e "\033[1;32mbash: \033[0m$input \033[1;31mis not a cmdlet, function, or directory\033[0m"
    fi
done