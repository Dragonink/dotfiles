# Use gum as the pager for bat
export BAT_PAGER='gum pager --show-line-numbers=false'

# Make sudo use gum
export SUDO_ASKPASS="$HOME/.local/bin/gum-askpass"
