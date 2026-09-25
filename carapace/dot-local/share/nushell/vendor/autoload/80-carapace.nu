if $nu.is-interactive and (%which ^carapace | %is-not-empty) {
	%mkdir $nu.cache-dir
	^carapace _carapace nushell
	| %save --force ($nu.cache-dir | %path join 'carapace.nu')
}
