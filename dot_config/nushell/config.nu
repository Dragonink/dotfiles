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
	let LIST_ESEP = {
		from_string: {|s| $s | split row (char esep)}
		to_string: {|v| $v | str join (char esep)}
	}
	let PATH_LIST_ESEP = {
		from_string: {|s| $s | split row (char esep) | path expand --no-symlink}
		to_string: {|v| $v | path expand --no-symlink | str join (char esep)}
	}
	let LIST_SPACE = {
		from_string: {|s| $s | split row (char space)}
		to_string: {|v| $v | str join (char space)}
	}
	let LIST_COMMA = {
		from_string: {|s| $s | split row ','}
		to_string: {|v| $v | str join ','}
	}

	$env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | merge {
		"AQ_DRM_DEVICES": $PATH_LIST_ESEP,
		"CARAPACE_BRIDGES": $LIST_COMMA,
		"LANGUAGE": $LIST_ESEP,
		"XDG_CONFIG_DIRS": $PATH_LIST_ESEP,
		"XDG_DATA_DIRS": $PATH_LIST_ESEP,
		"UWSM_FINALIZE_VARNAMES": $LIST_SPACE,
		"UWSM_WAIT_VARNAMES": $LIST_SPACE,
	}
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
