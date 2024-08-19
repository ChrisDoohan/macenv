#!/bin/bash
set -e

source ./shared/common_functions.sh

install_alfred_4() {
    local app_name="Alfred 4.app"
    local package_url="https://cachefly.alfredapp.com/Alfred_4.8_1312.dmg"
    local dmg_file="Alfred_4.dmg"

    log_initialize "Checking for Alfred 4 installation..."

    # Check if Alfred 4 is already installed
    if in_applications_folder "Alfred 4"; then
        log_success "Alfred 4 is already installed."
        return 0
    fi

    log_initialize "Downloading Alfred 4..."

    # Download the .dmg file
    wget -q -O "$dmg_file" "$package_url"

    log_initialize "Mounting Alfred 4 image..."

    # Mount the .dmg file and accurately capture the mount point
    local mount_point=$(hdiutil attach "$dmg_file" -nobrowse -noverify -noautoopen | grep "Apple_HFS" | awk '{print $NF}')

    if [ -z "$mount_point" ]; then
        log_failure "Failed to mount Alfred 4 image."
        rm "$dmg_file"
        return 1
    fi

    # Copy the application to the /Applications directory
    log_initialize "Copying Alfred 4 to /Applications..."
    cp -R "${mount_point}/${app_name}" /Applications/

    # Check for successful copy
    if [ $? -ne 0 ]; then
        log_failure "Failed to copy Alfred 4 to /Applications."
        hdiutil detach "$mount_point" -quiet
        rm "$dmg_file"
        return 1
    fi

    # Unmount the .dmg
    log_initialize "Unmounting Alfred 4 image..."
    hdiutil detach "$mount_point" -quiet

    # Clean up the downloaded .dmg file
    rm "$dmg_file"

    log_success "Alfred 4 installation completed."
}

log_initialize "INSTALLING PRODUCTIVITY TOOLS..."

brew_install_packages qrencode

brew_install_casks rectangle karabiner-elements keepingyouawake

# Alfred 4 can not be managed using brew casks -- only Alfred 5 can, so I will
# swap this under brew's domain once I have purchased the newer license
install_alfred_4

log_success "PRODUCTIVITY TOOLS INSTALLED."
