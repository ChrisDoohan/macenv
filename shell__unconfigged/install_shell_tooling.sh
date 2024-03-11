#!/bin/bash
set -e

source ./shared/common_functions.sh

install_omz() {
    log_initialize "Ensuring oh-my-zsh is installed..."

    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_success "Oh-my-zsh is already installed."
    else
        log_initialize "Installing oh-my-zsh..."
        sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        if [ -d "$HOME/.oh-my-zsh" ]; then
            log_success "Oh-my-zsh installation completed successfully."
        else
            log_failure "Failed to install oh-my-zsh."
            return 1
        fi
    fi
}

log_initialize "INSTALLING BASIC SHELL TOOLING..."

install_omz

brew_install_packages lsd bat asdf magic-wormhole neofetch lolcat

log_success "SHELL TOOLING INSTALLED."
