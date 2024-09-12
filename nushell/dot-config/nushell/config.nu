$env.config = {
	show_banner: false,
	use_kitty_protocol: true,

	ls: {
		use_ls_colors: true,
		clickable_links: true,
	},

	rm: {
		always_trash: true,
	},
}


# Make nushell use Starship
use ~/.cache/nushell/starship.nu
