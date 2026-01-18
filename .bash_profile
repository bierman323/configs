# .bash_profile - sourced for login shells
# This sources .bashrc which loads oh-my-bash and custom configuration

# Source .bashrc if it exists (loads oh-my-bash + custom config)
if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
