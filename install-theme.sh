#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify
#
# Description:
#   - Backs up and removes previous zsh/Oh-My-Zsh configurations.
#   - Installs required packages and sets up Oh-My-Zsh.
#   - For Termux, restores default color settings and disables welcome banner.
#   - Displays colored messages for better user guidance.
#   - Does NOT force-close terminal to prevent crashes.
#
# Usage:
#   bash install-theme
# =================================================================

# Color definitions
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"

HOME_DIR="$HOME"

# --------------------- Core Functions ---------------------

remove_all_config() {
    echo -e "${YELLOW}Removing previous configurations...${NC}"
    
    # Backup .zshrc
    if [ -f "$HOME_DIR/.zshrc" ]; then
        backup_file="$HOME_DIR/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
        cp -v "$HOME_DIR/.zshrc" "$backup_file" || {
            echo -e "${RED}Failed to backup .zshrc! Exiting.${NC}"
            exit 1
        }
        rm -f "$HOME_DIR/.zshrc"
    fi

    # Cleanup directories
    for dir in ".oh-my-zsh" ".termux"; do
        if [ -d "$HOME_DIR/$dir" ]; then
            rm -rfv "$HOME_DIR/$dir" || {
                echo -e "${RED}Failed to remove $dir! Exiting.${NC}"
                exit 1
            }
        fi
    done

    # Remove Termux banner config
    [ -f "$HOME_DIR/.hushlogin" ] && rm -f "$HOME_DIR/.hushlogin"
}

append_config() {
    echo -e "${YELLOW}Applying new configuration...${NC}"
    cat << 'EOF' >> "$HOME_DIR/.zshrc"

# BEGIN UNIVERSAL THEME
# Speedtest aliases
if command -v speedtest-go >/dev/null 2>&1; then
    alias spd='speedtest-go'
elif command -v speedtest-cli >/dev/null 2>&1; then
    alias spd='speedtest-cli'
fi

alias neo='neofetch'
alias edit='nano $HOME/.zshrc'

# Load zsh-autosuggestions if available
[ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# END UNIVERSAL THEME
EOF
}

# --------------------- Environment Handlers ---------------------

install_termux() {
    echo -e "${YELLOW}Setting up Termux...${NC}"
    
    # Update & install packages
    pkg update -y && pkg upgrade -y || {
        echo -e "${RED}Failed to update packages! Exiting.${NC}"
        exit 1
    }
    
    pkg install -y zsh git curl speedtest-go neofetch || {
        echo -e "${RED}Package installation failed! Exiting.${NC}"
        exit 1
    }

    # Install Oh-My-Zsh
    echo -e "${YELLOW}Installing Oh-My-Zsh...${NC}"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
        echo -e "${RED}Oh-My-Zsh installation failed! Exiting.${NC}"
        exit 1
    }

    # Install zsh-autosuggestions
    if [ ! -d "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || {
                echo -e "${RED}Failed to clone zsh-autosuggestions! Exiting.${NC}"
                exit 1
            }
    fi

    # Termux color settings
    mkdir -p "$HOME_DIR/.termux"
    cat << 'EOF' > "$HOME_DIR/.termux/colors.properties"
background = #1E1E1E
foreground = #C7C7C7
# ... (rest of color config)
EOF

    termux-reload-settings
    touch "$HOME_DIR/.hushlogin"
    append_config
    
    echo -e "${GREEN}Termux setup complete! Run 'chsh -s zsh' and restart Termux.${NC}"
}

install_linux() {
    echo -e "${YELLOW}Setting up Linux...${NC}"
    
    # Install packages
    if command -v apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get install -y zsh git curl speedtest-cli neofetch
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm zsh git curl speedtest-cli neofetch
    elif command -v dnf >/dev/null; then
        sudo dnf install -y zsh git curl speedtest-cli neofetch
    else
        echo -e "${RED}Unsupported package manager. Install packages manually.${NC}"
        exit 1
    fi || {
        echo -e "${RED}Package installation failed! Exiting.${NC}"
        exit 1
    }

    # Install Oh-My-Zsh
    echo -e "${YELLOW}Installing Oh-My-Zsh...${NC}"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
        echo -e "${RED}Oh-My-Zsh installation failed! Exiting.${NC}"
        exit 1
    }

    # Install zsh-autosuggestions
    if [ ! -d "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || {
                echo -e "${RED}Failed to clone zsh-autosuggestions! Exiting.${NC}"
                exit 1
            }
    fi

    append_config
    
    # Shell change instructions
    echo -e "${GREEN}Linux setup complete! Change your shell manually:"
    echo -e "${YELLOW}1. Run 'chsh -s $(which zsh)'"
    echo -e "${YELLOW}2. Log out and log back in.${NC}"
}

# --------------------- Main Execution ---------------------

remove_all_config

if [ -d "/data/data/com.termux/files/usr" ]; then
    install_termux
elif [ -f /etc/os-release ]; then
    install_linux
else
    echo -e "${RED}Unsupported environment!${NC}"
    exit 1
fi

echo -e "\n${GREEN}Setup completed successfully!${NC}"
echo -e "${YELLOW}Restart your terminal to apply changes.${NC}"
