#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

# ---------------------- Konfigurasi Termux ----------------------
TERMUX_HOME="/data/data/com.termux/files/home"
ZSH_CUSTOM="$TERMUX_HOME/.oh-my-zsh/custom"

# ---------------------- Warna dan Prompt ----------------------
setup_zshrc() {
    cat > "$TERMUX_HOME/.zshrc" <<EOL
# Termify Configuration
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)

source \$ZSH/oh-my-zsh.sh

# Custom Prompt
PROMPT='%{\$fg[green]%}%n@%m%{\$reset_color%}:%{\$fg[cyan]%}%~%{\$reset_color%} ➤ '
EOL
}

# ---------------------- Proses Instalasi ----------------------
echo "[+] Memulai instalasi Termify..."

# Update package
pkg update -y && pkg upgrade -y

# Install dependensi
pkg install -y zsh git curl

# Install Oh My Zsh tanpa interaksi
if [ ! -d "$TERMUX_HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Setup .zshrc
setup_zshrc

# Set warna default (Dracula)
echo -e "background=#1E1E1E\nforeground=#C7C7C7" > "$TERMUX_HOME/.termux/colors.properties"
termux-reload-settings

echo "[+] Instalasi selesai!"
echo "[+] Jalankan: source ~/.zshrc"