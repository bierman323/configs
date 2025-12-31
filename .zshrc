# Check if this is interactive or some kind of script. Only configure it if it is interactive login.

# Check what OS is running
export OS_VERSION=$(uname)

# Detect environment type
export IS_WORK_MAC=false
export IS_DOCKER=false
export IS_WSL=false

# Check for work Mac (GlobalProtect installed)
if [[ "$OS_VERSION" == "Darwin" ]] && [[ -d "/Applications/GlobalProtect.app" ]]; then
  export IS_WORK_MAC=true
fi

# Check for Docker container
if [[ -f "/.dockerenv" ]]; then
  export IS_DOCKER=true
fi

# Check for WSL2
if [[ "$OS_VERSION" == "Linux" ]] && grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
  export IS_WSL=true
fi

# Load work-specific configuration if on work Mac
if [[ "$IS_WORK_MAC" == "true" ]] && [[ -f "$HOME/.config/dotfiles/.zshrc_work" ]]; then
  source "$HOME/.config/dotfiles/.zshrc_work"
fi

# Load sensitive environment variables (not tracked in git)
# These should be stored in your private dotfiles repo
if [[ -f "$HOME/.config/dotfiles/.zshrc_sensitive" ]]; then
  source "$HOME/.config/dotfiles/.zshrc_sensitive"
fi

# Load work-specific sensitive variables if on work Mac
if [[ "$IS_WORK_MAC" == "true" ]] && [[ -f "$HOME/.config/dotfiles/.zshrc_work_sensitive" ]]; then
  source "$HOME/.config/dotfiles/.zshrc_work_sensitive"
fi

# Configure OhMyZSH first
OH_MY_PATH="$HOME/.local/oh-my-zsh"
if [ -d "$OH_MY_PATH" ]; then
  source .zshrc_ohmyzsh
fi

# Check if brew is installed. This needs to be above places where
# you are checking for applications that are installed with brew
if [[ -d "/opt/homebrew/bin/brew" ]]; then
  path+=('/opt/homebrew/bin/brew')
  export path
elif [[ -d "/home/linuxbrew/.linuxbrew/Homebrew/bin" ]]; then
  path+=('/home/linuxbrew/.linuxbrew/Homebrew/bin')
  export path
fi

# Check if there is a bin directory in the home directory
if [[ -d "$HOME/bin" ]]; then
  path+=("$HOME/bin")
  export path
fi

# Configure eza
if (( $+commands[eza] )); then
  source .zshrc_eza
fi

# Configure bat
if (( $+commands[bat] )); then
  alias cat="bat"
elif (( $+commands[batcat] )); then
  alias cat="batcat"
fi

# Configure fzf
if (( $+commands[fzf] )); then
  # Alias Search System
  alias ass='alias | fzf'

  # preview
  alias fzfp="fzf-tmux --preview 'bat --style=numbers --color=always --line-range :500 {}'"

  # check if fzf is the newer version that accepts the shell information for shortcuts
  if fzf --help 2>&1 | grep -q -- '--zsh'; then
    eval "$(fzf --zsh)"
  else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
  fi
  export FZF_DEFAULT_OPTS_FILE=$HOME/.fzfrc
fi

# Choose the default editor
if (( $+commands[nvim] )); then
  export EDITOR='nvim'
  alias sudovim='sudo -E nvim'
else
  export EDITOR='vim'
  alias sudovim='sudo -E vim'
fi

# Configure duf
if (( $+commands[duf] )); then
  alias df='duf'
fi

# Configure ncdu
if (( $+commands[ncdu] )); then
  alias du='ncdu --color dark'
fi

# Configure zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Configure thefuck
if (( $+commands[thefuck] )); then
  eval $(thefuck --alias)
fi

# Create some Mac specific
if [[ "$OS_VERSION" == "Darwin" ]]; then
  alias audiokill="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
  path+=('/Applications/Visual Studio Code.app/Contents/Resources/app/bin/')
fi

export HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space

# get rid of the beeps
unsetopt BEEP
unsetopt LIST_BEEP

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


## Need to fix this for different OS's and functionality. Split it into multiple files per OS/Function
path+=('/opt/local/bin' '/opt/local/sbin/' "$HOME/.local/bin/")
export PATH
