#!/bin/bash
set -e

source ./shared/common_functions.sh

log_initialize "ENSURING GITHUB SSH KEYS IN .ssh/github..."

ssh_key_dir="$HOME/.ssh/github"
ssh_key_path="$ssh_key_dir/id_rsa_github"
ssh_config_path="$HOME/.ssh/config"

# Ensure the .ssh and github key directory exist
mkdir -p "$ssh_key_dir"
chmod 700 "$HOME/.ssh"
chmod 700 "$ssh_key_dir"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Ensure the SSH config file exists and contains configuration for the new key path
if ! grep -q "IdentityFile $ssh_key_path" "$ssh_config_path" 2>/dev/null; then
    cat >> "$ssh_config_path" <<EOF

# GitHub SSH configuration
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $ssh_key_path
EOF
    chmod 644 "$ssh_config_path"
fi

# Generate the SSH key for GitHub if it doesn't exist
if [ ! -f "$ssh_key_path" ]; then
    echo "Generating a new SSH key for GitHub..."
    ssh-keygen -t ed25519 -f "$ssh_key_path" -C "chrisdoohan@gmail.com"

    # Add the SSH key to the ssh-agent, for THIS session
    ssh-add --apple-use-keychain "$ssh_key_path"

    # Copy the SSH public key to the clipboard for GitHub configuration
    pbcopy < "${ssh_key_path}.pub"

    echo "The public SSH key has been copied to your clipboard. Please add it to your GitHub account at https://github.com/settings/ssh/new" | lolcat
else
    echo "GitHub SSH key already exists at $ssh_key_path."
fi

log_success "GITHUB SSH KEYS CONFIGURED."
