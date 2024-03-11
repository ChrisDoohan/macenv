# How to Invoke
From repo root directory, run `./setup.sh`. This script is partially interactive and will require the system password a few times.

This repo should be fully idempotent. Run it whenever you want. Alter it. Run it again.

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
  - Restore saved Alfred config using jank directory method
- WRT Finder
  - Add user home to sidebar pane favorites (you don't want to know why this can't be automated)
  - Create `screenshots` directory, add it to sidebar pane favorites, and set it as the default screenshot location

