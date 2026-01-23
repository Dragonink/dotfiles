use std/config


# Disable the welcome banner
$env.config.show_banner = false
# Use SQLite for the shell history
$env.config.history = $env.config.history | merge {
	file_format: 'sqlite',
	isolation: true,
}
# Enable fuzzy matching completions
$env.config.completions.algorithm = 'fuzzy'
# Make ls display icons
$env.config.hooks.display_output = {
	if (term size).columns >= 100 {
		table --icons --expand
	} else {
		table --icons
	}
}
# Make rm trash files by default
$env.config.rm.always_trash = true

# Customize Nushell logging format
$env.NU_LOG_FORMAT = $"%ANSI_STOP%(ansi attr_dimmed)%DATE%(ansi reset) %ANSI_START%%LEVEL%%ANSI_STOP% %MSG%%ANSI_STOP%"

# Convert environment variables to Nushell
export-env {
	let PATH_LIST_ESEP = config env-conversions | get path
	let LIST_ESEP = {
		from_string: { split row (char esep) },
		to_string: { str join (char esep) },
	}
	let LIST_SPACE = {
		from_string: { split row (char space) },
		to_string: { str join (char space) },
	}
	let LIST_COMMA = {
		from_string: { split row ',' },
		to_string: { str join ',' },
	}
	let LIST_SEMICOLON = {
		from_string: { split row ';' },
		to_string: { str join ';' },
	}

	$env.ENV_CONVERSIONS = $env.ENV_CONVERSIONS | merge {
		"APP2UNIT_SLICES": {
			from_string: {
				split row (char space)
				| split column '='
				| transpose --as-record --header-row
			},
			to_string: {
				items {|kind, session| $"($kind)=($session)"}
				| str join (char space)
			},
		},
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

# Configure pinentry to use the correct TTY
$env.GPG_TTY = ^tty
^gpg-connect-agent updatestartuptty /bye | ignore

# Enable the kitty protocol
if $nu.is-interactive {
	export-env {
		let progressive_enhancement = try {
			term query $'(ansi csi)?u' --prefix $'(ansi csi)?' --terminator 'u'
			| decode ascii
			| into int
			true
		} catch {
			false
		}
		let primary_device_attrs = try {
			term query $'(ansi csi)c' --prefix $'(ansi csi)?' --terminator 'c'
			| decode ascii
			| split row ';'
			true
		} catch {
			false
		}

		$env.config.use_kitty_protocol = $progressive_enhancement and $primary_device_attrs
	}
}

# Make Carapace handle the completions
if (which carapace | is-not-empty) {
	$env.config.completions.external = {
		enable: true,
		completer: {|spans: list<string>|
			# If the command is an alias, get its expansion
			let expanded_alias = scope aliases
			| where name == $spans.0
			| get --optional 0.expansion
			let spans = if $expanded_alias != null {
				# Replace the alias by its expansion
				$spans
				| skip 1
				| prepend ($expanded_alias | split row (char space))
			} else {
				$spans
			}

			^carapace $spans.0 nushell ...$spans
			| from json
			| if ($in | default [] | where value =~ 'ERR$' | is-empty) { $in } else { null }
		},
	}
}
