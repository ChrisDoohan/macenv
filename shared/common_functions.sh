log_initialize() {
    # Yellow
    printf "$(date '+%Y-%m-%d %H:%M:%S') - \033[33m%s\033[0m\n" "$1"
}

log_success() {
    # Green
    printf "$(date '+%Y-%m-%d %H:%M:%S') - \033[32m%s\033[0m\n" "$1"
}

log_failure() {
    # Red
    printf "$(date '+%Y-%m-%d %H:%M:%S') - \033[31m%s\033[0m\n" "$1"
}

symlink_config() {
    local source_file="$1"
    local target_file="$2"
    
    # Check if the source file exists
    if [ ! -f "$source_file" ]; then
        echo "Error: Source file does not exist: $source_file"
        return 1 # Exit the function with an error status
    fi
    
    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
        echo "Backing up existing file: $(basename "$target_file")."
        mv "$target_file" "${target_file}.backup"
    fi

    if [ -L "$target_file" ]; then
        if [ ! -e "$target_file" ]; then
            echo "Warning: Symlink already exists but points to a non-existent file: $(basename "$target_file"). Removing broken symlink."
            rm "$target_file"
            # Optionally, you can choose to exit the function after removing the broken symlink
            # return 1
        else
            echo "Symlink already exists for $(basename "$target_file")."
            return 0 # Exit the function successfully
        fi
    fi

    echo "Creating symlink for $(basename "$target_file")."
    ln -s "$source_file" "$target_file"
    echo "Symlink created for $(basename "$target_file")."
}

# Function to install packages via Home-brew
brew_install_packages() {
    for package in "$@"; do  # Iterate over the arguments passed to the function
        log_initialize "Ensuring $package install"
        if brew list "$package" &>/dev/null; then
            log_success "$package is already installed."
        else
            log_initialize "Installing $package..."
            if brew install "$package"; then
                log_success "$package installation completed."
            else
                log_failure "Failed to install $package."
            fi
        fi
    done
}

# Function to install cask applications via Homebrew
brew_install_casks() {
    for cask in "$@"; do  # Iterate over the arguments passed to the function
        log_initialize "Ensuring $cask is installed"
        if brew list --cask "$cask" &>/dev/null; then
            log_success "$cask is already installed."
        else
            log_initialize "Installing $cask..."
            if brew install --cask "$cask"; then
                log_success "$cask installation completed."
            else
                log_failure "Failed to install $cask."
            fi
        fi
    done
}

# Function to check if an application is installed by checking the Applications directory
in_applications_folder() {
    local app_path="/Applications/$1.app"
    if [ -d "$app_path" ]; then
        return 0  # True, app is installed
    else
        return 1  # False, app is not installed
    fi
}
