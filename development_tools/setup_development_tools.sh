#!/bin/bash
set -e

source ./shared/common_functions.sh

log_initialize "INSTALLING GENERAL DEVELOPMENT TOOLS..."

brew_install_packages tmux cloc

brew_install_casks docker pgadmin4

log_success "GENERAL DEVELOPMENT TOOLS INSTALLED."
