#!/bin/bash
set -e
source ./shared/common_functions.sh

install_nerd_fonts() {
    # The first two of these are for use in vs code. The rest are for p10k
    declare -a font_urls=(
        "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Medium/RobotoMonoNerdFontMono-Medium.ttf"
        "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Medium-Italic/RobotoMonoNerdFontMono-MediumItalic.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
    )

    # User directory to store the fonts
    font_dir="$HOME/Library/Fonts"
    mkdir -p "$font_dir"

    # Download and install each font
    for url in "${font_urls[@]}"; do
        # Extracting the font file name from the URL
        font_name=$(basename "$url")

        # Check if the font already exists
        if [ -f "$font_dir/$font_name" ]; then
            log_success "$font_name is already installed."
            continue
        fi

        log_initialize "Downloading $font_name..."
        wget -q -O "${font_dir}/${font_name}" "$url"

        if [ $? -eq 0 ]; then
            log_success "$font_name has been installed successfully."
        else
            log_failure "Failed to download $font_name."
            return 1
        fi
    done
}

log_initialize "INSTALLING FONTS..."

install_nerd_fonts

log_success "FONTS INSTALLED."
