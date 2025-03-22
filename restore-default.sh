#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e "${YELLOW}*** Rolling Back Universal Terminal Theme Changes ***${NC}"

# 1. Restore .zshrc backup
backup=$(ls -t "$HOME"/.zshrc.backup.* 2>/dev/null | head -n 1)

if [ -z "$backup" ]; then
    echo -e "${RED}No backup .zshrc found. Cannot perform rollback.${NC}"
    exit 1
fi

echo -e "${GREEN}Restoring your backup from: $backup${NC}"
cp -f "$backup" "$HOME/.zshrc"

# 2. Remove theme components
echo -e "${YELLOW}Cleaning up theme components...${NC}"

to_remove=(
    "$HOME/.oh-my-zsh"
    "$HOME/.termux"
    "$HOME/.hushlogin"
    "$HOME/.zsh-autosuggestions"
    "$HOME/.zcompdump*"  
)

for item in "${to_remove[@]}"; do
    if [ -e "$item" ]; then
        rm -rf "$item"
        echo -e "${GREEN}Removed: $item${NC}"
    fi
done

# 3. Handle khusus untuk Arch Linux
if [ -f "/etc/arch-release" ]; then
    echo -e "${YELLOW}Performing additional cleanup for Arch Linux...${NC}"
    sudo pacman -Rns --noconfirm zsh-autosuggestions 2>/dev/null
    sudo chmod 755 /usr/share/zsh/site-functions
fi

echo -e "${GREEN}Rollback complete! Please manually restart your terminal.${NC}"

exit 0