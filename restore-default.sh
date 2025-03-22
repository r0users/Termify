#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

echo -e "${YELLOW}*** Termify Configuration Rollback ***${NC}"
echo -e "${YELLOW}Restoring default terminal settings...${NC}\n"

# ---------------------- Sanitize Backup ----------------------
# Restore .zshrc backup with OMZ references removed
backup_file=$(ls -t "$HOME"/.zshrc.backup.* 2>/dev/null | head -n 1)

if [ -z "$backup_file" ]; then
    echo -e "${RED}ERROR: No backup file found.${NC}"
    exit 1
fi

echo -e "${GREEN}Restoring backup: ${backup_file}${NC}"

# Hapus bagian yang refer ke Oh-My-Zsh & theme
sed '/^# BEGIN UNIVERSAL THEME/,/^# END UNIVERSAL THEME/d' "$backup_file" | \
sed '/oh-my-zsh/d' > "$HOME/.zshrc.tmp" && \
mv "$HOME/.zshrc.tmp" "$HOME/.zshrc" || {
    echo -e "${RED}Failed to sanitize .zshrc!${NC}"
    exit 1
}

# ---------------------- Cleanup Process ----------------------
echo -e "\n${YELLOW}Cleaning up components...${NC}"

declare -a targets=(
    "$HOME/.oh-my-zsh"
    "$HOME/.termux"
    "$HOME/.hushlogin"
    "$HOME/.zcompdump*"
    "$HOME/.zsh-autosuggestions"
)

for target in "${targets[@]}"; do
    if [ -e "$target" ]; then
        echo -e "${GREEN}Removing: ${target}${NC}"
        rm -rf "$target"
    fi
done

# ---------------------- Post-Rollback Checks ----------------------
# Cek jika shell masih zsh
if [ -n "$ZSH_VERSION" ]; then
    echo -e "\n${YELLOW}Warning: You're still using Zsh.${NC}"
    echo -e "To avoid errors, switch to bash:"
    echo -e "${GREEN}exec bash${NC}"
fi

echo -e "\n${GREEN}Rollback complete!${NC}"
echo -e "${YELLOW}Restart terminal or run 'exec bash' immediately.${NC}"
