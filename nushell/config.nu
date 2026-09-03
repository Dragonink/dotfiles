$env.config.show_banner = false

$env.config.edit_mode = 'helix'

$env.config.cursor_shape = $env.config.cursor_shape | merge (
	$env.XDG_CONFIG_HOME?
	| default --empty ($nu.home-dir | path join '.config')
	| path join 'helix' 'config.toml'
	| open
	| get --optional editor.cursor-shape
	| default {}
	| transpose key value
	| update key { $"helix_($in)" }
	| update value { match $in {
		'block' => 'block',
		'bar' => 'line',
		'underline' => 'underscore',
		_ => 'inherit',
	} }
	| transpose --as-record --header-row
)

$env.config.datetime_format = {
	normal: "%c",
	table: "%c",
}

$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true

$env.config.completions.algorithm = 'fuzzy'

$env.config.hooks.display_output = { table --icons }

if $nu.is-interactive {
	# REF: https://sw.kovidgoyal.net/kitty/keyboard-protocol/#detection-of-support-for-this-protocol

	let progressive_enhancement: bool = try {
		term query $'(ansi csi)?u' --prefix $'(ansi csi)?' --terminator 'u'
		| decode ascii
		| split row ';'
		| each { into int }
		true
	} catch {
		false
	}
	let primary_device_attributes: bool = try {
		term query $'(ansi csi)c' --prefix $'(ansi csi)?' --terminator 'c'
		| decode ascii
		| split row ';'
		| each { into int }
		true
	} catch {
		false
	}

	$env.config.use_kitty_protocol = $primary_device_attributes and $progressive_enhancement
}

$env.NU_LOG_FORMAT = $"%ANSI_STOP%(ansi attr_dimmed)%DATE%(ansi reset_dimmed) %ANSI_START%%LEVEL%%ANSI_STOP% %MSG%%ANSI_STOP%"

$env.config.rm.always_trash = true
