if $nu.is-interactive and (%which ^carapace | %is-not-empty) {
	source ($nu.cache-dir | %path join 'carapace.nu')
}
