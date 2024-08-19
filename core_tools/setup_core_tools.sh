#!/bin/bash
set -e
source ./shared/common_functions.sh

install_homebrew() {
    log_initialize "Ensuring Homebrew installation"
    if command -v brew >/dev/null 2>&1; then
        log_success "Homebrew is already installed."
    else
        log_initialize "Homebrew not found. Installing it from scratch"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # This entry in the profile sets the binding to brew. Anyone using brew will need to source this first
        if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' $HOME/.zprofile; then
            (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/chris/.zprofile
        fi

        log_success "Homebrew installation completed."
fi
}

symlink_git_config() {
    log_initialize "Symlinking ~/.gitconfig, for git and for delta"
    symlink_config "$HOME/macenv/dotfiles/.gitconfig" "$HOME/.gitconfig"
    log_success "Symlinking completed."
}

log_initialize "SETTING UP CORE TOOLS..."

install_homebrew
# Get access to Homebrew via `brew`
source $HOME/.zprofile

brew_install_packages wget git-delta trash

symlink_git_config

brew_install_casks visual-studio-code iterm2

log_success "CORE TOOLS SETUP COMPLETED."
