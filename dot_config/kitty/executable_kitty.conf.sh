#!/usr/bin/env bash
set -euo pipefail

# Use Nushell
if nu="$(command -v nu)"; then
	#shellcheck disable=2016
	printf "shell $nu --execute '%s'\n" '$env.config.use_kitty_protocol = true'
fi

# Configure Git to use the diff kitten
GIT_CONFIG_COUNT="${GIT_CONFIG_COUNT:-0}"
function git_config() {
	echo "env GIT_CONFIG_KEY_$GIT_CONFIG_COUNT=$1"
	echo "env GIT_CONFIG_VALUE_$GIT_CONFIG_COUNT=$2"

	GIT_CONFIG_COUNT="$((GIT_CONFIG_COUNT + 1))"
}
#shellcheck disable=2016
git_config 'difftool.kitty.cmd' 'kitten diff $LOCAL $REMOTE'
git_config 'alias.difftool-kitty' 'difftool --tool=kitty --dir-diff --no-symlinks'
echo "env GIT_CONFIG_COUNT=$GIT_CONFIG_COUNT"
