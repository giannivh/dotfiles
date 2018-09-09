# Load the config files
for config (~/.config/zsh/**/*.zsh) source $config

# Load private config, if any
if [ -e ~/.zsh_private ]; then
    source ~/.zsh_private
fi