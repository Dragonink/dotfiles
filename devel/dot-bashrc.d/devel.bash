# Make
MAKEFLAGS="--jobs=$(nproc)"
export MAKEFLAGS

# Rust
#shellcheck disable=SC1091
source "${CARGO_HOME:-$HOME/.cargo}/env"
export CLIPPY_CONF_DIR="$XDG_CONFIG_HOME/clippy"
