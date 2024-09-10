# Make
MAKEFLAGS="--jobs=$(nproc)"
export MAKEFLAGS

# Rust
if [ -f "${CARGO_HOME:-$HOME/.cargo}/env" ]; then
	#shellcheck disable=SC1091
	source "${CARGO_HOME:-$HOME/.cargo}/env"
fi
export CLIPPY_CONF_DIR="$XDG_CONFIG_HOME/clippy"
