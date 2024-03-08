# Path to your oh-my-zsh installation.
export ZSH=$HOME/.local/oh-my-zsh

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="half-life"
ZSH_THEME="dstufft"


# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

#
# Setup PATH the right way
path+=('/opt/local/bin' '/opt/local/sbin/' '/usr/local/go/bin' "$HOME/.local/bin")
export PATH

alias df='df -h'
alias du='du -h'
alias fuck='sudo $(history -p \!\!)'
alias audiokill="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias via='vim -- "$(ls -t | head -n 1)"'
alias cat='batcat'
alias sudovim='sudo -E vim'
alias ls="eza --icons"
alias ll="eza -alh --icons"
alias tree="eza --tree --icons"

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
unsetopt LIST_BEEP

# I want vim to be my editor everywhere
export EDITOR='vim'
eval "$(zoxide init zsh)"
