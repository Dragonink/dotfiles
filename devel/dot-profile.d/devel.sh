# Make
MAKEFLAGS="--jobs=$(nproc)"
export MAKEFLAGS

# Rust
export CLIPPY_CONF_DIR="$XDG_CONFIG_HOME/clippy"
