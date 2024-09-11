export-env {
	$env.NU_CACHE = $'($env.XDG_CACHE_HOME)/nushell'
	mkdir $env.NU_CACHE

	source ./env.nu.d/starship.nu
}
