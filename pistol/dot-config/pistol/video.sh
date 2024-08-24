#!/usr/bin/env bash
set -euo pipefail

thumb="$(mktemp -t 'ffmpegthumb.XXX.jpg')"


ffmpegthumbnailer -s 0 -f -m -i "$1" -o "$thumb" > /dev/null 2>&1
pistol "$thumb"

rm --force "$thumb"
