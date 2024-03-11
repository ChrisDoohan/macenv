#!/bin/bash
set -e
source ./shared/common_functions.sh

log_initialize "SYMLINKING .p10k.zsh..."

symlink_config "$HOME/macenv/dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"

log_success ".p10k.zsh symlinked."

log_initialize "SYMLINKING .zshrc..."

symlink_config "$HOME/macenv/dotfiles/.zshrc" "$HOME/.zshrc"

log_success ".zshrc symlinked."
