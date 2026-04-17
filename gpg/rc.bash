#shellcheck shell=bash

# Set correct TTY for pinentry
GPG_TTY="$(tty)"
export GPG_TTY
gpg-connect-agent UPDATESTARTUPTTY /bye > /dev/null
