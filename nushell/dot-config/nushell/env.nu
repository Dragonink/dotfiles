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

# Custom completions
const COMPLETIONS: path = $nu.default-config-dir | path join 'nu_scripts' 'custom-completions'
source ($COMPLETIONS | path join 'bat' 'bat-completions.nu')
source ($COMPLETIONS | path join 'cargo' 'cargo-completions.nu')
source ($COMPLETIONS | path join 'eza' 'eza-completions.nu')
source ($COMPLETIONS | path join 'git' 'git-completions.nu')
source ($COMPLETIONS | path join 'less' 'less-completions.nu')
source ($COMPLETIONS | path join 'make' 'make-completions.nu')
source ($COMPLETIONS | path join 'man' 'man-completions.nu')
source ($COMPLETIONS | path join 'rustup' 'rustup-completions.nu')
source ($COMPLETIONS | path join 'ssh' 'ssh-completions.nu')
source ($COMPLETIONS | path join 'tar' 'tar-completions.nu')
source ($COMPLETIONS | path join 'typst' 'typst-completions.nu')


# Write scripts in cache to use in config.nu
if (which starship | length) > 0 {
	^starship init nu | save --force ($nu.cache-dir | path join 'starship.nu')
}
if (which broot | length) > 0 {
	^broot --print-shell-function nushell | save --force ($nu.cache-dir | path join 'broot.nu')
}
