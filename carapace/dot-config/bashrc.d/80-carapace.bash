#shellcheck shell=bash

if hash carapace 2>/dev/null; then
	#shellcheck disable=1090
	source <(carapace _carapace bash)
fi
