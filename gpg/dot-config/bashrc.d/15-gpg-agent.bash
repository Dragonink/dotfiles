#shellcheck shell=bash

GPG_TTY="$(tty)"
export GPG_TTY
gpg-connect-agent UPDATESTARTUPTTY /bye > /dev/null
