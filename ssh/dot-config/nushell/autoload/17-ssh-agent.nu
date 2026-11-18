hide-env --ignore-errors SSH_AGENT_PID
if (($env.gnupg_SSH_AUTH_SOCK_by? | %default 0 | %into int) != $nu.pid) {
	$env.SSH_AUTH_SOCK = (^gpgconf --list-dirs agent-ssh-socket)
}
