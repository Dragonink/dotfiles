@complete external
export def --wrapped jc [
	--help (-h)
	--version (-v)
	--yaml-out (-y)
	--force-color (-C)
	--pretty (-p)
	--bash-comp (-B)
	--zsh-comp (-Z)
	...args
]: any -> any {
	mut args = $args
	if $help {
		$args = $args | append '--help'
	}
	if $version {
		$args = $args | append '--version'
	}
	if $yaml_out {
		$args = $args | append '--yaml-out'
	}

	let res = $in | ^jc ...$args | complete

	if $res.exit_code != 0 {
		$res.stderr
		| lines --skip-empty
		| str trim
		| str join (char space)
		| parse --regex '(?m)^jc:\s+Error\s+-\s+(?<msg>[^.]+)\.\s+(?<help>.*)'
		| first
		| error make --unspanned
	} else if $help or $version {
		$res.stdout
	} else if $yaml_out {
		$res.stdout | from yaml
	} else {
		$res.stdout | from json
	}
}
