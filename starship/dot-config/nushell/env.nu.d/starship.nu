let init_module = $env.NU_CACHE | path join 'starship.nu'

^starship init nu | save --force $init_module
