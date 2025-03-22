#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

# ---------------------- Konfigurasi Path ----------------------
TERMUX_HOME="/data/data/com.termux/files/home"
ZSH_CUSTOM="$TERMUX_HOME/.oh-my-zsh/custom"
ZSH_RC="$TERMUX_HOME/.zshrc"

# ---------------------- Tema dan Warna ----------------------
THEMES=(
    "Dracula:#1E1E1E:#C7C7C7:➤"
    "Nord:#2E3440:#D8DEE9:➤"
    "Solarized:#002B36:#839496:➤"
    "Default:#000000:#FFFFFF:$"
)

# ---------------------- Fungsi Tampilan ----------------------
show_menu() {
    clear
    echo "╔═══════════════════════════╗"
    echo "║   ${BOLD}Termify Theme Manager${NC}   ║"
    echo "╠═══════════════════════════╣"
    
    for i in "${!THEMES[@]}"; do
        local theme_name=$(echo "${THEMES[i]}" | cut -d':' -f1)
        if [ $i -eq $selected ]; then
            echo "║ ${GREEN}▶ ${theme_name}${NC} $(printf '%*s' $((20 - ${#theme_name})) ║"
        else
            echo "║   ${theme_name} $(printf '%*s' $((20 - ${#theme_name})) ║"
        fi
    done
    
    echo "╚═══════════════════════════╝"
}

# ---------------------- Fungsi Setup ----------------------
initial_setup() {
    # Setup storage
    if [ ! -d "$TERMUX_HOME/storage" ]; then
        echo "Mengaktifkan izin penyimpanan..."
        termux-setup-storage
        sleep 2
    fi

    # Update packages
    pkg update -y && pkg upgrade -y
    pkg install -y zsh git curl

    # Install Oh My Zsh
    if [ ! -d "$TERMUX_HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install auto-suggestions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    fi

    # Backup existing config
    cp "$ZSH_RC" "$ZSH_RC.bak"
}

# ---------------------- Fungsi Apply Theme ----------------------
apply_theme() {
    IFS=':' read -r name bg fg prompt <<< "${THEMES[$selected]}"
    
    # Set warna Termux
    echo -e "background=$bg\nforeground=$fg" > "$TERMUX_HOME/.termux/colors.properties"
    termux-reload-settings

    # Buat konfigurasi ZSH baru
    cat > "$ZSH_RC" <<EOL
# Termify Configuration
export ZSH="$TERMUX_HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)

source \$ZSH/oh-my-zsh.sh

# Custom prompt
PROMPT='%{\$fg[green]%}%n@%m%{\$reset_color%}:%{\$fg[cyan]%}%~%{\$reset_color%} ${prompt} '
EOL

    echo "Tema ${name} berhasil diterapkan!"
    echo "Jalankan 'source ~/.zshrc' atau restart Termux"
    exit 0
}

# ---------------------- Main Program ----------------------
initial_setup
selected=0

while true; do
    show_menu
    
    read -n1 -p "Pilih dengan [W/S] dan Enter: " input
    case $input in
        w) ((selected--)); [ $selected -lt 0 ] && selected=$((${#THEMES[@]}-1)) ;;
        s) ((selected++)); [ $selected -ge ${#THEMES[@]} ] && selected=0 ;;
        "") apply_theme ;;
    esac
done
