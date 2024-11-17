# Configure environment conversions
export-env {
	let convert_list = {|separator: string| {
		from_string: {|s: string| $s | str trim | split row $separator},
		to_string: {|val| $val | str join $separator},
	}}
	let convert_path_list = {|separator = (char env_sep)| {
		from_string: {|s: string| do (do $convert_list $separator | get from_string) $s | path expand --no-symlink},
		to_string: {|val: list<path>| do (do $convert_list $separator | get to_string) ($val | path expand --no-symlink)},
	}}

	$env.ENV_CONVERSIONS = {
	  PATH: (do $convert_path_list),
		XDG_DATA_DIRS: (do $convert_path_list),

		KITTY_CONF_NUSHELL: (do $convert_list (char newline)),

		DEBUGINFOD_URLS: (do $convert_list (char space)),
	}
}


# Write scripts in cache to use in config.nu
const CACHE: path = '~/.cache/nushell'
if (which starship | length) > 0 {
	^starship init nu | save --force ($CACHE | path join 'starship.nu')
}
if (which broot | length) > 0 {
	^broot --print-shell-function nushell | save --force ($CACHE | path join 'broot.nu')
}
