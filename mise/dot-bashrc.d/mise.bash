# Make mise use all CPU cores
MISE_JOBS="$(nproc)"
export MISE_JOBS

# Source mise's bash integration
eval "$(mise activate bash)"
