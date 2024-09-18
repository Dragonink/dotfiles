$env.config = {
	show_banner: false,

	ls: {
		use_ls_colors: true,
	},

	rm: {
		always_trash: true,
	},
}

source config.nu.d/kitty.nu


# Make nushell use Starship
source ~/.cache/nushell/starship.nu
