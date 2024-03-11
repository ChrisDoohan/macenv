#!/bin/bash
set -e

source ./shared/common_functions.sh

log_initialize "CONFIGURING KEYBOARD REPEAT TIMINGS..."

# Set the key repeat rate to its maximum (minimum is 2, 1 is too fast and causes issues)
defaults write NSGlobalDomain KeyRepeat -int 2

# Set the delay until repeat to its shortest
defaults write NSGlobalDomain InitialKeyRepeat -int 15

log_success "KEYBOARD REPEAT TIMINGS CONFIGURED."
