@complete external
export def --wrapped jc [
	--yaml-out (-y)
	--force-color (-C)
	--pretty (-p)
	--bash-comp (-B)
	--zsh-comp (-Z)
	--version (-v)
	--help (-h)
	...args
]: any -> any {
	if $help {
		^jc --help
		return
	}
	if $version {
		^jc --version
		return
	}
	if $bash_comp {
		^jc --bash-comp
		return
	}
	if $zsh_comp {
		^jc --zsh-comp
		return
	}

	mut args = $args
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
	} else if $yaml_out {
		$res.stdout | from yaml
	} else {
		$res.stdout | from json
	}
}
