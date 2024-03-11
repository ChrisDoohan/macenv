#!/bin/bash
set -e

source ./shared/common_functions.sh

# Make it really obvious when something goes wrong
handle_exit() {
    exit_status=$?
    if [ $exit_status -ne 0 ]; then
        log_failure "ERROR: The script has exited unexpectedly with status $exit_status."
    fi
}
trap handle_exit EXIT

log_initialize "Starting setup process..."

# Call the core tools setup
./core_tools/setup_core_tools.sh
source $HOME/.zprofile

# Make sure browsers are in place -- this will install chrome and firefox via
# brew casks if and only if the browser is not already present in the
# applications directory (it will not double install into the cellar)
./browsers/setup_browsers.sh

# Install fonts for VS Code -- allow p10k to install its own terminal font later
./custom_fonts/setup_custom_fonts.sh

# Because config is the most likely thing to break, it is done at the end of
# all setup. The following performs a vanilla install, so that the shell is
# guaranteed to be in a working state, regardless of at what point the rest of
# the scripts break.
./shell__unconfigged/install_shell_tooling.sh

./productivity/setup_productivity_tools.sh

./development_tools/setup_development_tools.sh

./communication/setup_communication_tools.sh

./optional_configuration/configure_finder.sh

./optional_configuration/configure_keyboard_timings.sh

./github/setup_ssh_keys.sh

# The job is done. It's all jokes from here on out
MEME_DIR="./memes"
SELECTED_MEME=$(find "$MEME_DIR" -type f | shuf -n 1)
lolcat "$SELECTED_MEME"

echo -e "\nSetup process completed successfully." \
"\nYou're welcome for saving you so much time." \
"\nFor next configuration steps, please take a look at the readme in this repo.\n" | lolcat
