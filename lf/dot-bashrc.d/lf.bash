# Set up cd on quit
function lf() {
  LF_CD_FILE="$(mktemp -t 'lfcd.XXX.cwd')"

  env LF_CD_FILE="$LF_CD_FILE" lf "$@"

  local cwd
  if cwd="$(cat "$LF_CD_FILE")" && [ -n "$cwd" ]; then
    # shellcheck disable=SC2164
    cd "$cwd"
  fi

  builtin command rm --force "$LF_CD_FILE"
}
