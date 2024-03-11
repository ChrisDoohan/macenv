#!/bin/bash
set -e

source ./shared/common_functions.sh

install_syntax_highlighting() {
    # Note that this doesn't complete the shell bind. It's expected that
    # restoring .zshrc later on will supply that binding.

    log_initialize "Setting up zsh-syntax-highlighting..."
    brew_install_packages zsh-syntax-highlighting
    log_success "zsh-syntax-highlighting is set up."
}

install_zsh_auto_suggestions() {
    local target_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    log_initialize "Setting up zsh-autosuggestions..."

    # Check if the directory already exists
    if [ -d "$target_dir" ]; then
        log_success "zsh-autosuggestions is already set up."
        return 0
    fi

    git clone https://github.com/zsh-users/zsh-autosuggestions "$target_dir"
    log_success "zsh-autosuggestions setup completed."
}

install_p10k() {
    # Again, this doesn't complete the binding or activate p10k in any way.
    # It just puts it in place
    local target_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    log_initialize "Installing p10k..."

    # Check if the directory already exists
    if [ -d "$target_dir" ]; then
        log_success "p10k is already installed."
        return 0
    fi

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$target_dir"
    log_success "p10k installation completed."
}

log_initialize "ENSURING ZSH PLUGINS ARE INSTALLED..."

install_syntax_highlighting

install_zsh_auto_suggestions

install_p10k

log_success "ZSH PLUGINS ARE INSTALLED."
