#!/bin/bash
set -e
source ./shared/common_functions.sh

# Function to install browsers using cask if they're not already installed or available via command-line
install_browsers() {
    declare -a browsers=("google-chrome" "firefox")

    for browser in "${browsers[@]}"; do
        local app_name=""
        case $browser in
            google-chrome) app_name="Google Chrome";;
            firefox) app_name="Firefox";;
        esac
        
        log_initialize "Ensuring installation for $app_name"
        
        if in_applications_folder "$app_name"; then
            log_success "$app_name is already installed."
        else
            log_initialize "Installing $app_name..."
            if brew install --cask "$browser"; then
                log_success "$app_name installation completed."
            else
                log_failure "Failed to install $app_name."
            fi
        fi
    done
}

log_initialize "SETTING UP BROWSERS..."

install_browsers

log_success "BROWSER SETUP COMPLETED."
