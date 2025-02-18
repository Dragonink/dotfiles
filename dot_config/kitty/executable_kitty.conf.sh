#!/bin/sh

# Use Nushell
if nu="$(command -v nu)"; then
  echo "shell $nu"
  echo "env SHELL=$nu"
fi
