# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/Users/brad.bierman/.oh-my-bash'

# Set theme - powerbash10k is the bash equivalent of powerlevel10k
# Fallback to half-life if needed (matching zsh config)
if [[ -d "$OSH/themes/powerbash10k" ]]; then
  OSH_THEME="powerbash10k"
else
  OSH_THEME="half-life"
fi

# Disable auto-update prompt (matching zsh DISABLE_UPDATE_PROMPT=true)
DISABLE_AUTO_UPDATE="true"

# Display Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true

# To enable/disable display of Python virtualenv and condaenv
OMB_USE_SUDO=true

# Which completions would you like to load?
completions=(
  git
  ssh
  brew
  system
)

# Which aliases would you like to load?
aliases=(
  general
)

# Which plugins would you like to load?
# Note: vi-mode in bash is enabled via 'set -o vi' below
# Note: zoxide and fzf are configured in .bash_profile_config
plugins=(
  git
)

source "$OSH"/oh-my-bash.sh

# Enable vi mode (equivalent to zsh vi-mode plugin)
set -o vi

# Source the main bash_profile configuration
# This includes all your custom aliases, functions, PATH, etc.
if [[ -f "$HOME/.bash_profile_config" ]]; then
  source "$HOME/.bash_profile_config"
fi
