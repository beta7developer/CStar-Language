#!/bin/bash

while true; do
    echo ""
    echo -e "\033[1;32m$(whoami)@$(hostname)\033[0m \x1B[35mUCRT64\x1B[0m\033[0;33m" $PWD "\033[0m"


    read -p "$ " input
    eval "$input"
done