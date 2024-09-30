# Make
MAKEFLAGS="--jobs=$(nproc)"
export MAKEFLAGS

# Rust
export CARGO_HOME="$HOME/.cargo"
if [ -f "$CARGO_HOME/env" ]; then
	#shellcheck disable=SC1091
	source "$CARGO_HOME/env"
fi
export CLIPPY_CONF_DIR="$XDG_CONFIG_HOME/clippy"
