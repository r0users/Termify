#!/bin/bash
# Termify Minimal Installer
# Repository: https://github.com/r0users/Termify

# Install dependensi dasar
pkg update -y && pkg upgrade -y
pkg install -y zsh git curl

# Install Oh My Zsh tanpa interaksi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Exit otomatis
exit