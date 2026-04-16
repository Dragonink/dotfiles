#shellcheck shell=sh

set -a
eval "$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)"
set +a

PROFILE_DIR="$XDG_CONFIG_HOME/profile.d"
if [ -d "$PROFILE_DIR" ]; then
	for include in "$PROFILE_DIR"/*.sh; do
		if [ -r "$include" ]; then
			#shellcheck disable=1090
			. "$include"
		fi
	done
fi
