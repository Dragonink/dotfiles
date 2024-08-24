#!/usr/bin/env bash
set -euo pipefail

COLUMNS="${FZF_PREVIEW_COLUMNS:-}"
export COLUMNS="${2:-$COLUMNS}"

LINES="${FZF_PREVIEW_LINES:-}"
if [ -n "$LINES" ]; then
	LINES=$((LINES - 1))
fi
export LINES="${3:-$LINES}"

X="${FZF_PREVIEW_LEFT:-}"
X="${4:-$X}"

Y="${FZF_PREVIEW_TOP:-}"
Y="${5:-$Y}"


args=(
	'--stdin=no'
	'--transfer-mode=stream'
	'--unicode-placeholder'
)
if [ -n "$COLUMNS" ] && [ -n "$LINES" ] && [ -n "$X" ] && [ -n "$Y" ]; then
	args+=("--place=${COLUMNS}x${LINES}@${X}x${Y}")
fi

kitty +kitten icat "${args[@]}" "$1" > /dev/tty
