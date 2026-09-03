# [Environment variable conversions](https://www.nushell.sh/book/environment.html#environment-variable-conversions)

# Constructs an environment variable conversion for a list which items are separated by `$separator`.
def list [separator: string]: nothing -> record<from_string: closure, to_string: closure> {
	{
		from_string: { str trim | split row $separator },
		to_string: { str join $separator },
	}
}


# $env.ENV_CONVERSIONS.PATH = list (char esep)

# XDG Base Directories
$env.ENV_CONVERSIONS.XDG_CONFIG_DIRS = list (char esep)
$env.ENV_CONVERSIONS.XDG_DATA_DIRS = list (char esep)

# Language
$env.ENV_CONVERSIONS.LANGUAGE = list (char esep)

# debuginfod
$env.ENV_CONVERSIONS.DEBUGINFOD_URLS = list (char space)

# Carapace
$env.ENV_CONVERSIONS.CARAPACE_BRIDGES = list ','

# App2Unit
$env.ENV_CONVERSIONS.APP2UNIT_SLICES = {
	from_string: {
		split row (char space)
		| split column '='
		| str trim
		| transpose --as-record --header-row
	},
	to_string: {
		transpose key slice
		| each { $"($in.key)=($in.slice)" }
		| str join (char space)
	},
}

# UWSM
$env.ENV_CONVERSIONS.UWSM_FINALIZE_VARNAMES = list (char space)
$env.ENV_CONVERSIONS.UWSM_WAIT_VARNAMES = list (char space)

# Hyprland
$env.ENV_CONVERSIONS.AQ_DRM_DEVICES = list (char esep)

# GUI libraries
$env.ENV_CONVERSIONS.GDK_BACKEND = list ','
$env.ENV_CONVERSIONS.QT_QPA_PLATFORM = list ';'
$env.ENV_CONVERSIONS.SDL_VIDEODRIVER = list ','

# Ghostty
$env.ENV_CONVERSIONS.GHOSTTY_SHELL_FEATURES = list ','
