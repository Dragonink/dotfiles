# Set up cd on quit
function yazi() {
	local temp="$(mktemp -t "yazi.XXX.cwd")"

	builtin command yazi --cwd-file="$temp" "$@"

	if local cwd="$(cat "$temp")" && [ -n "$cwd" ]; then
		cd "$cwd"
	fi
	builtin command rm --force "$temp"
}

# Shortcut to yazi
alias yy='yazi'
