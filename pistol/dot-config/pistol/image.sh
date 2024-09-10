#!/usr/bin/env bash
set -euo pipefail

export COLUMNS="${2:-${COLUMNS:-}}"
export LINES="${3:-${LINES:-}}"
X="${4:-}"
Y="${5:-}"


args=(
	'--stdin=no'
	'--transfer-mode=stream'
	'--unicode-placeholder'
)
if [ -n "$COLUMNS" ] && [ -n "$LINES" ] && [ -n "$X" ] && [ -n "$Y" ]; then
	args+=("--place=${COLUMNS}x${LINES}@${X}x${Y}")
fi

kitty +kitten icat "${args[@]}" "$1" > /dev/tty
