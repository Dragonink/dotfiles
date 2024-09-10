# Make mise use all CPU cores
MISE_JOBS="$(nproc)"
export MISE_JOBS

# Source mise bash integration
eval "$(mise activate bash)"
eval "$(mise completion bash)"
# Force mise integration for init scripts
eval "$(mise hook-env --shell=bash)"
