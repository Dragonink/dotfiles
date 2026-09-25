$env.config.show_banner = false

$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true

$env.config.completions.algorithm = 'fuzzy'

if $nu.is-interactive {
	# REF: https://sw.kovidgoyal.net/kitty/keyboard-protocol/#detection-of-support-for-this-protocol

	def "term query flags" [
		query: oneof<binary, string>
		terminator: oneof<binary, string>
	]: nothing -> list<int> {
		%term query $query --prefix $'(ansi csi)?' --terminator $terminator
		| decode ascii
		| split row ';'
		| each { into int }
	}

	let progressive_enhancements: bool = try {
		term query flags $'(ansi csi)?u' 'u'
		true
	} catch {
		false
	}
	let primary_attributes: bool = try {
		term query flags $'(ansi csi)c' 'c'
		true
	} catch {
		false
	}

	$env.config.use_kitty_protocol = $primary_attributes and $progressive_enhancements
}
