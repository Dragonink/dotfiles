#!/bin/bash
set -euo pipefail

export COLUMNS="${2:-}"
export LINES="${3:-}"
X="${4:-}"
Y="${5:-}"


args=('--stdin=no' '--transfer-mode=stream')
if [ -n "$COLUMNS" ] && [ -n "$LINES" ] && [ -n "$X" ] && [ -n "$Y" ]; then
	args+=("--place=${COLUMNS}x${LINES}@${X}x${Y}")
fi

kitty +kitten icat "${args[@]}" "$1" > /dev/tty
exit $?
