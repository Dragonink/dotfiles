let HELIX_CONFIG_DIR: path = (
	$env.XDG_CONFIG_HOME?
	| default --empty ($nu.home-dir | path join '.config')
	| path join 'helix'
)

let HELIX_CONFIG_FILE: path = $HELIX_CONFIG_DIR | path join 'config.toml'
if not ($HELIX_CONFIG_FILE | path exists) {
	return
}
let HELIX_CONFIG: record = open $HELIX_CONFIG_FILE

$env.config.edit_mode = 'helix'

$env.config.cursor_shape = $env.config.cursor_shape | merge (
	$HELIX_CONFIG
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

let HELIX_THEME_FILE: path = $HELIX_CONFIG_DIR | path join 'themes' $"($HELIX_CONFIG | get theme).toml"
if not ($HELIX_THEME_FILE | path exists) {
	return
}
let HELIX_THEME: record = open $HELIX_THEME_FILE
def resolve_color []: string -> string {
	let color = $in
	$HELIX_THEME.palette
	| get --optional $color
	| default $color
}
def append_attrs [attr: string]: [
	string -> record,
	record -> record,
] {
	if ($in | describe) == string { $in | wrap fg } else { $in }
	| upsert attr? { default '' | $"($in)($attr)" }
}

const NU_HELIX_TRANSLATE = {
	header: $.variable,
	row_index: $.variable,
	hints: $.'ui.virtual',
	shape_binary: $.constant,
	shape_bool: $.constant,
	shape_int: $.constant,
	shape_float: $.constant,
	shape_datetime: $.constant,
	# shape_globpattern: $.constant,
	shape_string: $.string,
	shape_filepath: $.string,
	shape_operator: $.operator,
	shape_pipe: $.operator,
	shape_variable: $.variable,
	shape_vardecl: $.variable,
	shape_flag: $.variable,
	shape_internalcall: $.'function.special',
	shape_external: $.function,
	shape_externalarg: $.string,
}
$env.config.color_config = $env.config.color_config | merge (
	$NU_HELIX_TRANSLATE
	| transpose nu helix
	| update helix {
		let key = $in
		let color = $HELIX_THEME | get $key
		if ($color | describe) == string {
			$color | resolve_color
		} else {
			$color
			| update fg? { resolve_color }
			| update bg? { resolve_color }
			| insert attr {|row|
				$row.modifiers?
				| default []
				| append (if ('underline' in $row) { 'underlined' })
				| each { match $in {
					'bold' => 'b',
					'dim' => 'd',
					'italic' => 'i',
					'underlined' => 'u',
					'slow_blink' | 'rapid_blink' => 'l',
					'reversed' => 'r',
					'hidden' => 'h',
					'crossed_out' => 's',
				} }
				| str join
			}
			| select --optional fg bg attr
		}
	}
	| transpose --as-record --header-row
	| update header { append_attrs 'b' }
	| update row_index { append_attrs 'b' }
)
