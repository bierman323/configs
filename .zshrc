# Check if this is interactive or some kind of script. Only configure it if it is interactive login. 

# Check what OS is running
OS_VERSION='uname'

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

# plugins=(git)

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

# I want vim to be my ediotr everywhere
export EDITOR='nvim'
# Aliases should be split into different functionalities. Some are constant, so there should be a default
alias df='duf'
alias du='ncdu --color dark'
alias audiokill="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias sudovim='sudo -E nvim'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
# Alias Search System
alias ass='alias | fzf'

# preview
alias fzfp="fzf-tmux --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# setup fzf and it's shortcuts
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS_FILE=$HOME/.fzfrc

#setup zoxide
eval "$(zoxide init --cmd cd zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval $(thefuck --alias)

## Need to fix this for different OS's and functionality. Split it into multiple files per OS/Function
path+=('/opt/local/bin' '/opt/local/sbin/' '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/' '/Users/bbierman/.local/bin/')
export PATH