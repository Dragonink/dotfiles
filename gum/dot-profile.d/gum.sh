# Use gum pager as the default pager
export PAGER='gum pager'

# Use gum input as the sudo askpass
export SUDO_ASKPASS="$HOME/.local/bin/gum-askpass"
alias sudo='sudo --askpass'
