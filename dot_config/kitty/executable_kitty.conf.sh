#!/usr/bin/env bash
set -euo pipefail

# Use Nushell
if nu="$(command -v nu)"; then
  echo "shell $nu"
  echo "env SHELL=$nu"
fi

# Configure Git to use the diff kitten
GIT_CONFIG_COUNT="${GIT_CONFIG_COUNT:-0}"
function git_config() {
  echo "env GIT_CONFIG_KEY_$GIT_CONFIG_COUNT=$1"
  echo "env GIT_CONFIG_VALUE_$GIT_CONFIG_COUNT=$2"

  GIT_CONFIG_COUNT="$(($GIT_CONFIG_COUNT + 1))"
}
git_config 'difftool.kitty.cmd' 'kitten diff $LOCAL $REMOTE'
git_config 'alias.difftool-kitty' 'difftool --tool=kitty --dir-diff --no-symlinks'
echo "env GIT_CONFIG_COUNT=$GIT_CONFIG_COUNT"
