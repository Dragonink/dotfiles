#!/usr/bin/env bash
set -euo pipefail

if command -v starship > /dev/null; then
  starship init nu
fi
