# How to Invoke
From repo root directory, run `./setup.sh`. This script is partially interactive and will require the system password a few times. When Zsh is installed, it will automatically launch into a new shell and interrupt the script. Simply Ctrl+D out of it to resume the setup script.

This repo should be fully idempotent. Run it whenever you want. Alter it. Run it again.

# What Does This Do?
1. Installs `Homebrew`
1. Performs a vanilla install of
    1. `wget`
    1. `git-delta`
    1. `trash`
    1. `VS Code`
    1. `iTerm2`
1. Symlinks a `.gitconfig` file
1. Installs `FireFox` and `Google Chrome`
1. Installs custom patched fonts for the editor and terminal
1. Performs a vanilla install of the following terminal convenience tools:
    1. `Oh My Zsh`
    1. `lsd`
    1. `bat`
    1. `asdf`
    1. `magic-wormhole`
    1. `neofetch`
    1. `lolcat`
1. Installs the following MacOS interface tools:
    1. `rectangle`
    1. `keepingyouawake`
    1. `karabiner-elements`
    1. `alfred`
1. Installs the following secondary development tools
    1. `cloc`
    1. `docker`
    1. `pgadmin`
1. Installs `Slack`
1. Installs `Zoom`
1. Checks for GitHub SSH keys, creates them if nonexistent, and copies the public key to the clipboard
1. Performs quality of life tweaks to the Finder settings
1. Speeds up key repeat initialization timing and repeat rate
1. Installs `zsh` plugins, including `p10k`
1. Symlinks `zsh` and `p10k` dot files, to complete the shell configuration process

Note that this process is ordered to make it the easiest to debug. For example, if I am going to be debugging `zsh` plugins, I at least want to have a nice terminal, shell, and editor to work with during that process.

Also note that the symlinking function will rename any existing dotfiles to `.bak`, in place.

This repository does not install Postgres or any interpreters. All interpreters should be installed using `asdf`.


# Next Steps After Setup Scripts
A lof of the installed applications will need to be granted permissions the first time they ask for it. I've had some issues with Karabiner complaining it's missing permissions. If you believe it's acting up, try restarting it using its own internal restart mechanism, rather than by quitting and reopening it.
- Log out and back in for certain settings to take effect
- Open the following and launch video calls, to get permissions nags
  - Zoom
  - Slack
- WRT Rectangle
  - Open for the first time to grant permissions
  - Swap the hotkeys to Spectacle defaults
  - Enable "Launch on login"
- Open Karabiner Elements, and add the Right CMD -> ESC keybind
- Launch KeepingYouAwake, and select "Start at Login"
- WRT Firefox
  - Make it the default browser
  - Install uBlock Origin extension
  - Install BitWarden extension
- WRT the system dock
  - Remove bloatware icons
  - Resize
  - Remove genie animation
- WRT Alfred
  - Activate it using purchased license
  - Go into the Spotlight settings and unbind Cmd+Space. Rebind in Alfred
  - Restore saved Alfred config using jank directory method
- Open iTerm2 > Settings > Profiles > Text and set Font to MesloLGS NF.
- WRT Finder
  - Add user home to sidebar pane favorites (you don't want to know why this can't be automated)
  - Create `screenshots` directory, add it to sidebar pane favorites, and set it as the default screenshot location
- Turn off "Correct spelling automatically" and "Capitalize words automatically" in System Preferences > Keyboard > Text Input > Input Sources > Edit. Turn off smart quotes and double-space -> period in the same place.
- After GitHub is configured, turn on Settings Sync in VS Code and sign in, to pull settings
- Obsidian
  - Download the app from https://obsidian.md/download
  - Sign in, to start sync
  - Enter decryption key, from "Obsidian e2e encryption password" in Bitwarden

# Todo
- [ ] Add scratch directory and put it in the sidebar
- [ ] Automate the Obsidian setup