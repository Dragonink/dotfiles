# Set correct TTY for pinentry
$env.GPG_TTY = ^tty
^gpg-connect-agent UPDATESTARTUPTTY /bye | ignore
