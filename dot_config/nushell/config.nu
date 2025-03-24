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
		"XDG_CONFIG_DIRS": $PATH_LIST_ESEP,
		"XDG_DATA_DIRS": $PATH_LIST_ESEP,
		"UWSM_FINALIZE_VARNAMES": $LIST_SPACE,
		"UWSM_WAIT_VARNAMES": $LIST_SPACE,
	}
}


# Prepare the vendor directory
const VENDOR = $nu.data-dir | path join 'vendor'
mkdir $VENDOR

# Import bash-env
use ($VENDOR | path join 'bash-env.nu')


# Prepare the autoload directory
const VENDOR_AUTOLOAD = $VENDOR | path join 'autoload'
mkdir $VENDOR_AUTOLOAD

# Install Broot
const BROOT = $VENDOR_AUTOLOAD | path join 'broot.nu'
if (which broot | is-not-empty) {
	^broot --print-shell-function nushell | save --force $BROOT
	echo '^broot --set-install-state installed | ignore' | save --append $BROOT
} else {
	rm --force --permanent $BROOT
}

# Make Carapace handle the completions
const CARAPACE = $VENDOR_AUTOLOAD | path join 'carapace.nu'
if (which carapace | is-not-empty) {
	^carapace _carapace nushell | save --force $CARAPACE
} else {
	rm --force --permanent $CARAPACE
}

# Activate Starship
const STARSHIP = $VENDOR_AUTOLOAD | path join 'starship.nu'
if (which starship | is-not-empty) {
	^starship init nu | save --force $STARSHIP
} else {
	rm --force --permanent $STARSHIP
}
