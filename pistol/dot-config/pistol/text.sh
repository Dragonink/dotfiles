#!/usr/bin/env bash
set -euo pipefail

export COLUMNS="${2:-${COLUMNS:-}}"


args=(
	'--paging=never'
	'--color=always'
	'--style=numbers'
)
if [ -n "$COLUMNS" ]; then
	args+=("--terminal-width=${COLUMNS}")
fi

bat "${args[@]}" "$1"
