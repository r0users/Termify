#!/bin/bash
# Termify Clean Uninstaller
# Repo: https://github.com/r0users/Termify

# ----[ Configuration ]----
TERMUX_HOME="/data/data/com.termux/files/home"
COLOR_RESET="\033[0m"
RED="\033[1;31m"
GREEN="\033[1;32m"

# ----[ Core Functions ]----
reset_shell() {
    echo -e "${RED}»${COLOR_RESET} Reverting to bash..."
    chsh -s bash
    rm -f "${TERMUX_HOME}/.shell"
}

remove_ohmyzsh() {
    echo -e "${RED}»${COLOR_RESET} Removing Oh My Zsh..."
    rm -rf "${TERMUX_HOME}/.oh-my-zsh"
    rm -f "${TERMUX_HOME}/.zshrc"*
}

clean_artifacts() {
    echo -e "${RED}»${COLOR_RESET} Cleaning leftovers..."
    # Termify config files
    rm -f "${TERMUX_HOME}/.termux/colors.properties"
    rm -f "${TERMUX_HOME}/.hushlogin"
    
    # Cache and logs
    rm -rf "${TERMUX_HOME}/.termify_cache"
    rm -f "${TERMUX_HOME}/termify_install.log"
}

# ----[ Main Execution ]----
echo -e "${RED}[ TERMIFY UNINSTALLER ]${COLOR_RESET}"
read -p "Are you sure? This will remove ALL Termify components! [y/N] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    reset_shell
    remove_ohmyzsh
    clean_artifacts
    echo -e "\n${GREEN}✓ Uninstall complete!${COLOR_RESET}"
    echo "Close and reopen Termux to see changes"
else
    echo -e "\nUninstall canceled"
fi