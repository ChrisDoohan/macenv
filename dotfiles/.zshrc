# ============================================================================
#  ~/.zshrc — unified for macOS + Linux (source of truth: ~/macenv)
#  Platform-specific bits are guarded; everything else is shared.
# ============================================================================

# --- OS detection ----------------------------------------------------------
case "$OSTYPE" in
  darwin*) IS_MAC=1   ;;
  linux*)  IS_LINUX=1 ;;
esac

# --- Powerlevel10k instant prompt (keep near the very top) -----------------
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go ABOVE this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- oh-my-zsh -------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# NOTE: zsh-syntax-highlighting is sourced manually below (distro/brew
# controlled), so it is intentionally NOT in this plugins list.
plugins=(git colored-man-pages zsh-autosuggestions)
# Enable zsh-completions only if the custom plugin is actually cloned
[[ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions" ]] && plugins+=(zsh-completions)

# Prevent zsh from doing weird escape-character stuff on paste
DISABLE_MAGIC_FUNCTIONS=true

source "$ZSH/oh-my-zsh.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Version managers (per-OS) ---------------------------------------------
if (( IS_MAC )); then
  [ -r /opt/homebrew/opt/asdf/libexec/asdf.sh ] && . /opt/homebrew/opt/asdf/libexec/asdf.sh
  command -v rbenv >/dev/null && eval "$(rbenv init - zsh)"
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  # asdf v0.16+ just needs its shims on PATH
  [ -d "$HOME/.asdf/shims" ] && export PATH="$HOME/.asdf/shims:$PATH"
fi

# --- PATH ------------------------------------------------------------------
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# --- zsh-syntax-highlighting (distro: /usr/share, brew: /opt/homebrew) ------
for _zsh_hl in \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -r "$_zsh_hl" ]] && source "$_zsh_hl" && break
done
unset _zsh_hl

# --- Clipboard helpers (used by aliases/functions below) -------------------
if (( IS_MAC )); then
  clip()  { pbcopy; }
  clipp() { pbpaste; }
else
  clip()  { wl-copy; }
  clipp() { wl-paste; }
fi

# --- fzf + zoxide ----------------------------------------------------------
command -v fzf    >/dev/null && source <(fzf --zsh)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# --- Options ---------------------------------------------------------------
# Keep leading-space commands out of history
setopt HIST_IGNORE_SPACE

# --- Functions -------------------------------------------------------------
fixdate() {
  GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)";
}

# I'm tired of having to 'mkdir' before 'touch'
create() { mkdir -p "$(dirname "$1")" && touch "$1" ; }

serverless() {
  if [ -f "tmp/pids/server.pid" ]; then
    kill -9 "$(cat tmp/pids/server.pid | tr -d '%')"
  else
    echo "Server PID file not found."
  fi
}

# Kill browser/automation processes left over from test runs
tarnish() {
  local targets=("chromedriver" "Google Chrome" "Chromium" "chrome_crashpad_handler")
  for target in "${targets[@]}"; do
    local pids
    pids=$(pgrep -fi "$target" 2>/dev/null)
    if [[ -z "$pids" ]]; then
      echo "No processes found matching: $target"
    else
      echo "Killing processes matching '$target' (PIDs: $(echo $pids | tr '\n' ' '))..."
      pkill -9 -fi "$target"
      echo "Done."
    fi
  done
}

# Send a file with magic-wormhole and copy the receive command to the clipboard
ws() {
  wormhole send "$1" 2>&1 | tee >(
    grep --line-buffered "wormhole receive" | {
      head -n1 | tr -d '\n' | clip
      cat > /dev/null   # keep reading so the pipe isn't closed early
    }
  )
}

# --- Aliases: general ------------------------------------------------------
alias cz="code ~/.zshrc"
alias sz="source ~/.zshrc"

alias today="date +'%Y_%m_%d'"
alias now="date +'%T'"

alias ls="lsd"
alias lf="ls -d */"      # directories only
alias lah="ls -lah"

alias cat="bat --paging=never"
alias less="bat"

alias pt="python -m pytest"
alias ptd="python -m pytest --capture=no"
alias tf="terraform"
alias black="pre-commit run black --files"
alias pre="pre-commit run --files"
alias ipy="ipython"

# QR-encode the clipboard and print it in the terminal
alias qr="clipp | qrencode -o - -t UTF8"

# platform opener
if (( IS_MAC )); then alias o="open"; else alias o="xdg-open"; fi

# docker compose v2 (subcommand form on both platforms)
alias dc="docker compose"

# --- Aliases: git ----------------------------------------------------------
alias mybranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | grep Doohan | grep remote"
alias cb='git branch --show-current | tr -d "\n" | clip'
alias gpom='git pull origin master'
alias branch='git checkout $(git for-each-ref --sort=-committerdate refs/heads/ --format="%(refname:short)" | fzf)'

# --- Aliases: directories --------------------------------------------------
alias web='cd ~/web'
alias dl='cd ~/Downloads'

# --- Rails dev (generic; useful on any machine) ----------------------------
alias quietly='SUPPRESS_AR_LOGS=true'
alias serv='bin/rails s'
alias qserv='SUPPRESS_AR_LOGS=true bin/rails s'
alias brc='bin/rails console'
alias rr="bin/rspec"
alias rrr="rspec --exclude-pattern 'spec/features/**/*_spec.rb'"
alias dbs="rails db:migrate:status"
alias dbm="rails db:migrate"
alias dbr="rails db:rollback"
export RSPEC_RETRY_COUNT=0

# --- Completion: make aliases inherit rich completion ----------------------
# `dc` -> `docker compose`: rewrite the line then defer to docker's completer
if (( $+functions[_docker] )); then
  _dc() {
    words=(docker compose "${words[@]:1}")
    (( CURRENT++ ))
    _docker
  }
  compdef _dc dc
fi
# terraform ships its own completion engine (no _terraform function); wire tf too
if (( $+commands[terraform] )); then
  autoload -Uz bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform tf
fi

# ===========================================================================
#  macOS-only
# ===========================================================================
if (( IS_MAC )); then
  # macOS forks crash Ruby without this (objc fork-safety)
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

  # Canopy work conveniences
  alias give_backup="export AWS_PROFILE=DBBackupFolderRead-632380152743"
  alias stag="heroku run -s performance-l rails console --app canopy-staging"
  alias prod="heroku run -s performance-l rails console --app canopy-development"

  # Prevent running out of sockets while running the canopy tests
  ulimit -S -n 4096
  ulimit -H -n 4096

  # Nudge me if my ssh key isn't loaded
  ssh-add -l > /dev/null 2>&1 || echo "CGD: You need to run ssh-add"
fi

# ===========================================================================
#  Linux-only
# ===========================================================================
if (( IS_LINUX )); then
  alias vpn="mullvad"
  alias private="gocryptfs ~/encrypted_data ~/encrypted_data_view && XDG_CACHE_HOME=~/encrypted_data_view/thumbnails dolphin ~/encrypted_data_view && fusermount -u ~/encrypted_data_view"
fi

# --- Secrets (gitignored; not present on every machine) --------------------
[[ -f ~/macenv/dotfiles/.secrets.local ]] && source ~/macenv/dotfiles/.secrets.local
