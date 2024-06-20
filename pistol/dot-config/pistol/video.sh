#!/bin/bash
set -euo pipefail

export COLUMNS="${2:-}"
export LINES="${3:-}"
X="${4:-}"
Y="${5:-}"


args=('--stdin=yes' '--transfer-mode=stream')
if [ -n "$COLUMNS" ] && [ -n "$LINES" ] && [ -n "$X" ] && [ -n "$Y" ]; then
	args+=("--place=${COLUMNS}x${LINES}@${X}x${Y}")
fi

ffmpegthumbnailer -s 0 -m -i "$1" -o /dev/stdout | kitty +kitten icat "${args[@]}" > /dev/tty
exit $?
