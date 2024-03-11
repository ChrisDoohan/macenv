#!/bin/bash
set -e

source ./shared/common_functions.sh

log_initialize "INSTALLING COMMUNICATION TOOLS..."

brew_install_casks slack zoom

log_success "COMMUNICATION TOOLS INSTALLED."
