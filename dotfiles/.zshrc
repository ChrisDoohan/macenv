# chris@Chriss-MacBook-Pro.local Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/chris/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages zsh-autosuggestions)  # zsh-syntax-highlighting is not to be referenced here, if installed via brew

# The next variable has to be set in order to prevent zsh from doing weird escape
# character stuff on paste
DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh


function fixdate() {
    GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)";
}

# I'm tired of having to 'mkdir' before 'touch'
create() { mkdir -p "$(dirname "$1")" && touch "$1" ; }

# I sometimes need to be able to prevent commands from being stored in history
setopt HIST_IGNORE_SPACE

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# ALIASES
alias cz="code ~/.zshrc"
alias sz="source ~/.zshrc"
alias clip="pbcopy"
alias dc="docker-compose"

alias mybranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | grep Doohan | grep remote"

alias today="date +'%Y_%m_%d'"
# Get the current time
alias now="date +'%T'"

alias ls="lsd"
# Directories only
alias lf="ls -d */"
alias lah="ls -lah"

# Aliases for bat
alias cat='bat --paging=never'
alias less="bat"

alias pt="python -m pytest"
alias ptd="python -m pytest --capture=no"
alias tf="terraform"
alias black="pre-commit run black --files"
alias pre="pre-commit run --files"
alias ipy="ipython"

# Set up qr code alias to dump contents of clip board to qr code and display it
alias qr="pbpaste | qrencode -o - -t UTF8"


# Necessary for zsh syntax highlighting (plugin controlled by brew)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Init rbenv
eval "$(rbenv init - zsh)"

# Init nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

ssh-add -l > /dev/null 2>&1 || echo "CGD: You need to run ssh-add"

alias serv='bin/rails s'
alias qserv='SUPPRESS_AR_LOGS=true bin/rails s'
alias test='bin/rails spec'
alias brc='bin/rails console'

# Copy active branch name
alias cb='git branch --show-current | tr -d "\n" | pbcopy'
alias gpom='git pull origin master'



# Functions
serverless() {
  if [ -f "tmp/pids/server.pid" ]; then
    kill -9 "$(cat tmp/pids/server.pid | tr -d '%')"
  else
    echo "Server PID file not found."
  fi
}

tarnish() {
  echo "Searching for chromedriver processes..."
  pids=$(pgrep -f chromedriver)

  if [ -z "$pids" ]; then
    echo "No chromedriver processes found."
  else
    echo "Found chromedriver processes with PIDs: $pids"
    echo "Killing chromedriver processes..."
    pkill -f chromedriver
    echo "All chromedriver processes terminated."
  fi

  echo "Searching for Google Chrome processes..."
  pids=$(pgrep -f Google Chrome)

  if [ -z "$pids" ]; then
    echo "No Google Chrome processes found."
  else
    echo "Found Google Chrome processes with PIDs: $pids"
    echo "Killing Google Chrome processes..."
    pkill -f "Google Chrome"
    echo "All Google Chrome processes terminated."
  fi
}

# Necessary to prevent me from running out of sockets while running the canopy tests
ulimit -S -n 4096
ulimit -H -n 4096

ws() {
  wormhole send "$1" 2>&1 | tee >(
    grep --line-buffered "wormhole receive" | {
      head -n1 | tr -d '\n' | pbcopy
      # Continue reading the rest so the pipe isn’t closed early.
      cat > /dev/null
    }
  )
}
