# Sync subshell $PWD
function _nnn_cd() {
  if [ -n "$NNN_PIPE" ]; then
    printf '%s\0' "0c$PWD" > "$NNN_PIPE" !&
  fi
}
trap _nnn_cd EXIT

# Set up cd on quit
function nnn() {
  [ "${NNNLVL:-0}" -ne 0 ] && exit 1

  export NNN_TMPFILE="$(mktemp -t nnn.XXX.lastd)"
  builtin command nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    builtin source "$NNN_TMPFILE"
    builtin command rm --force "$NNN_TMPFILE"
  fi
}
