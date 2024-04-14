# No-op if the terminal is not kitty
[ -n "$KITTY_INSTALLATION_DIR" ] || return

# Enable kitty's bash integration
export KITTY_SHELL_INTEGRATION='enabled'
source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"

# Alias commands with kitty integrations
alias diff='kitten diff'
alias ssh='kitten ssh'
alias icat='kitten icat'
alias idot='dot -Gbgcolor=#00000000 -Gcolor=white -Gfontcolor=white -Ncolor=white -Nfontcolor=white -Ecolor=white -T png | icat'
