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


source ~/.cache/nushell/starship.nu
source ~/.cache/nushell/broot.nu
