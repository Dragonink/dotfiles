require("hyprland.rules")

function request(modname)
	if package.searchpath(modname, package.path) then
		return require(modname)
	end
end

request("hyprland.local")


-- Window swallowing
hl.config({
	misc = {
		enable_swallow = true,
		swallow_regex = "com\\.mitchellh\\.ghostty",
	},
})

-- Quickly configure unkown monitors
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
	cm = "auto",
})

-- RENDER
hl.config({
	general = {
		allow_tearing = true,
	},
	render = {
		new_render_scheduling = true,
	},
	misc = {
		vrr = 2, -- Fullscreen only
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- MISCELLANEOUS
hl.config({
	misc = {
		disable_autoreload = true,
	},
	ecosystem = {
		no_donation_nag = true,
	},
})
