@complete external
export def --wrapped jc [...args]: any -> oneof<string, record, table> {
	let run = ^jc ...$args | complete

	if $run.exit_code != 0 {
		error make --unspanned {
			msg: (
				$run.stderr
				| parse --regex '(?m)^(?:jc:\s+Error\s+-)?\s+(?<msg>.*)'
				| get msg
				| str join (char newline)
			),
		}
	} else if ($args | any { $in in ['--help', '--version'] or $in =~ '^-[a-zA-Z]*(h+|v)' }) {
		$run.stdout
	} else if ($args | any { $in == '--yaml-out' or $in =~ '^-[a-zA-Z]*y' }) {
		$run.stdout | from yaml
	} else {
		$run.stdout | from json
	}
}
