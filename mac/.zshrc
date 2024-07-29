# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/oh-my-zsh"

# ZSH_THEME="robbyrussell"
#ZSH_THEME="half-life"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="spaceship-prompt/spaceship"

# plugins=(git)

source $ZSH/oh-my-zsh.sh

# Setup PATH the right way
path+=('/opt/local/bin' '/opt/local/sbin/' '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/' '/Users/bbierman/.local/bin/')
export PATH

export HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space

alias df='duf'
alias du='ncdu --color dark'
alias audiokill="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias via='nvim "$(eza -fr -smod | head -n 1)"'
alias sudovim='sudo -E nvim'
alias cat="bat"
alias ls="eza --icons"
alias ll="eza -alho --icons --no-permissions --git-repos-no-status"
alias lsd="eza --icons -Dlh --git-repos"
alias lsf="eza --icons -flh --git"
alias tree="eza --icons --tree"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
# Alias Search System
alias ass='alias | fzf'

# preview
alias fzfp="fzf-tmux --preview 'bat --style=numbers --color=always --line-range :500 {}'"

alias fnp='nvim $(fzf -m --preview="bat --style=numbers --color=always --line-range :500 {}")'

# get rid of the beeps
unsetopt BEEP
unsetopt LIST_BEEP

# I want vim to be my ediotr everywhere
export EDITOR='nvim'

# change some configs for eza so that I can see things
export EZA_COLORS="da=38;5;217:uu=38;5;104"

# setup fzf and it's shortcuts
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS_FILE=$HOME/.fzfrc

#setup zoxide
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval $(thefuck --alias)
