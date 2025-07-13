use std/config


# Disable the welcome banner
$env.config.show_banner = false
# Use fuzzy matching for completions
$env.config.completions.algorithm = 'fuzzy'
# Use SQLite for the shell history
$env.config.history = $env.config.history | merge {
	file_format: 'sqlite',
	isolation: true,
}
# Make rm trash files by default
$env.config.rm.always_trash = true

# Convert environment variables to Nushell
export-env {
	let PATH_LIST_ESEP = config env-conversions | get path
	let LIST_ESEP = {
		from_string: { split row (char esep) }
		to_string: { str join (char esep) }
	}
	let LIST_SPACE = {
		from_string: { split row (char space) }
		to_string: { str join (char space) }
	}
	let LIST_COMMA = {
		from_string: { split row ',' }
		to_string: { str join ',' }
	}
	let LIST_SEMICOLON = {
		from_string: { split row ';' }
		to_string: { str join ';' }
	}

	$env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | merge {
		"AQ_DRM_DEVICES": $PATH_LIST_ESEP,
		"CARAPACE_BRIDGES": $LIST_COMMA,
		"GDK_BACKEND": $LIST_COMMA,
		"LANGUAGE": $LIST_ESEP,
		"QT_QPA_PLATFORM": $LIST_SEMICOLON,
		"SDL_VIDEODRIVER": $LIST_COMMA,
		"UWSM_FINALIZE_VARNAMES": $LIST_SPACE,
		"UWSM_WAIT_VARNAMES": $LIST_SPACE,
		"XDG_CONFIG_DIRS": $PATH_LIST_ESEP,
		"XDG_DATA_DIRS": $PATH_LIST_ESEP,
	}
}

# Enable the kitty protocol
export-env {
	const DCS = $'(ansi esc)P'
	const TN = 'TN' | encode hex

	let term = (
		term query --prefix $'($DCS)1+r($TN)=' --terminator (ansi st) $'($DCS)+q($TN)(ansi st)'
		| decode ascii
		| decode hex
		| decode ascii
	)

	$env.config.use_kitty_protocol = $term == 'xterm-kitty'
}

# Make Carapace handle the completions
if (which carapace | is-not-empty) {
	$env.config.completions.external = {
		enable: true,
		completer: {|spans: list<string>|
			let expanded_alias: string = scope aliases | where name == $spans.0 | get --ignore-errors 0 | get --ignore-errors expansion
			let spans: list<string> = if $expanded_alias != null {
				$spans | skip 1 | prepend ($expanded_alias | split row (char space) | take 1)
			} else {
				$spans
			}

			^carapace $spans.0 nushell ...$spans
			| from json
			| if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
		},
	}
}


# Prepare the vendor directory
const VENDOR = $nu.data-dir | path join 'vendor'
mkdir $VENDOR

# Import bash-env
use ($VENDOR | path join 'bash-env.nu')
