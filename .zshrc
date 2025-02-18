# Check if this is interactive or some kind of script. Only configure it if it is interactive login. 

# Check what OS is running
export OS_VERSION=$(uname)

# Configure OhMyZSH first
OH_MY_PATH="$HOME/.local/oh-my-zsh"
if [ -d "$OH_MY_PATH" ]; then
  source .zshrc_ohmyzsh
fi

# Configure eza
if (( $+commands[eza] )); then
  source .zshrc_eza
fi

# Configure bat
if (( $+commands[bat] )); then
  alias cat="bat"
fi

# Configure fzf
if (( $+commands[fzf] )); then
  # Alias Search System
  alias ass='alias | fzf'

  # preview
  alias fzfp="fzf-tmux --preview 'bat --style=numbers --color=always --line-range :500 {}'"

  # setup fzf and it's shortcuts
  eval "$(fzf --zsh)"
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
if (( $OS_VERSION=="Darwin")); then
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