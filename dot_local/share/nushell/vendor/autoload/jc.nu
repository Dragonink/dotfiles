@complete external
export def --wrapped jc [...args]: any -> oneof<string, record, table> {
	let run = ^jc ...$args | complete

	if $run.exit_code != 0 {
		error make --unspanned {
			msg: (
				$run.stderr
				| parse --regex 'jc:\s+Error\s+-\s+(?<error>.*)\s+Use "jc -h" for help.'
				| get 0.error
			),
			help: 'Use `^jc -h` for help',
		}
	}

	if ($args | any { $in in ['--help', '-v' '--version'] or $in =~ '^-h+$' }) {
		$run.stdout
	} else if ($args | any { $in in ['-y' '--yaml-out'] }) {
		$run.stdout | from yaml
	} else {
		$run.stdout | from json
	}
}
