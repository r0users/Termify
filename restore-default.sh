#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"  # No Color

echo -e "${YELLOW}*** Termify Configuration Rollback ***${NC}"
echo -e "${YELLOW}This will restore your terminal to default settings.${NC}\n"

# ---------------------- Backup Restoration ----------------------
# Restore latest .zshrc backup
backup_file=$(ls -t "$HOME"/.zshrc.backup.* 2>/dev/null | head -n 1)

if [ -z "$backup_file" ]; then
    echo -e "${RED}ERROR: No backup file found.${NC}"
    echo -e "${YELLOW}Tip: Backups are created during installation with timestamp.${NC}"
    exit 1
fi

echo -e "${GREEN}Restoring backup: ${backup_file}${NC}"
if ! cp -f "$backup_file" "$HOME/.zshrc"; then
    echo -e "${RED}Failed to restore .zshrc!${NC}"
    exit 1
fi

# ---------------------- Cleanup Process ----------------------
echo -e "\n${YELLOW}Cleaning up theme components...${NC}"

declare -a targets=(
    "$HOME/.oh-my-zsh"
    "$HOME/.termux"
    "$HOME/.hushlogin"
    "$HOME/.zcompdump*"
)

for target in "${targets[@]}"; do
    if [ -e "$target" ]; then
        echo -e "${GREEN}Removing: ${target}${NC}"
        rm -rf "$target"
    fi
done

# ---------------------- Post-Cleanup ----------------------
# Special handling for Termux
if [ -d "/data/data/com.termux/files/usr" ]; then
    echo -e "\n${YELLOW}Resetting Termux...${NC}"
    termux-reload-settings
fi

echo -e "\n${GREEN}Rollback complete!${NC}"
echo -e "${YELLOW}Please restart your terminal to apply changes.${NC}"
