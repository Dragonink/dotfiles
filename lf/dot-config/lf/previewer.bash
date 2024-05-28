#!/usr/bin/bash
set -euo pipefail

file="$1"
export COLUMNS="$2"
export LINES="$3"
x="$4"
y="$5"

ICAT_TRANSFER_MODE="$(kitty +kitten icat --detect-support)"

case "$(file --dereference --brief --mime-type "$file")" in
  # Display images in kitty
  image/*) kitty +kitten icat --stdin no --transfer-mode "$ICAT_TRANSFER_MODE" --place "${COLUMNS}x${LINES}@${x}x${y}" "$file" < /dev/null > /dev/tty;;
  # Display video's thumbnail in kitty
  video/*) ffmpegthumbnailer -i "$file" -o /dev/stdout -s 0 -m | kitty +kitten icat --stdin yes --transfer-mode "$ICAT_TRANSFER_MODE" --place "${COLUMNS}x${LINES}@${x}x${y}" > /dev/tty;;
  # Defaults
  *)
    if [ "$(file --dereference --brief --mime-encoding "$file")" = 'binary' ]; then
      # Use file and lesspipe if binary
      file "$file"
      echo
      lesspipe.sh "$file"
    else
      # Use bat if text
      bat --paging never --plain "$file"
    fi
    ;;
esac

exit 1
