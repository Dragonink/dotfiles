# Add mise shims to PATH
eval "$(mise activate bash --shims)"

# Make mise use all CPU cores
MISE_JOBS="$(nproc)"
export MISE_JOBS

# Source mise bash completions
eval "$(mise completion bash)"
