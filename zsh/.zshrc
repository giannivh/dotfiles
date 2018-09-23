# Load config files
for config in ~/.config/zsh/**/*.zsh; do
 source "$config"
done

# Load private config files
for config in ~/Private/zsh/**/*.zsh; do
  source "$config"
done
