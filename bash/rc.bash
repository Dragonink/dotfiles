#shellcheck shell=bash

# Exit if shell is not interactive
[[ $- != *i* ]] && return


BASHRC_DIR="$XDG_CONFIG_HOME/bashrc.d"
if [[ -d "$BASHRC_DIR" ]]; then
	for include in "$BASHRC_DIR"/*.bash; do
		if [[ -r "$include" ]]; then
			#shellcheck disable=1090
			source "$include"
		fi
	done
fi
