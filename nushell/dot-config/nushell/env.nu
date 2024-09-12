# Configure environment conversions
def env_conversion_path_list [separator: string] {
	{
		from_string: {|s| $s | split row $separator | path expand --no-symlink},
		to_string: {|val| $val | path expand --no-symlink | str join $separator},
	}
}
$env.ENV_CONVERSIONS = {
  'PATH': (env_conversion_path_list (char esep)),
	'XDG_DATA_DIRS': (env_conversion_path_list (char esep)),
}


# Write scripts in cache to use in config.nu
const CACHE: path = '~/.cache/nushell'
^starship init nu | save --force ($CACHE | path join 'starship.nu')
