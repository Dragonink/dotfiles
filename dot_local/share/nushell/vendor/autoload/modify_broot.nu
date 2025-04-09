#!/usr/bin/env bash
set -euo pipefail

if command -v broot > /dev/null; then
  broot --print-shell-function nushell
  echo '^broot --set-install-state installed | ignore'
fi

