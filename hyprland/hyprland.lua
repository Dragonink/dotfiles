require("hyprland.layout")
require("hyprland.decorations")
require("hyprland.input")
require("hyprland.bindings")
require("hyprland.rules")

function request(modname)
	if package.searchpath(modname, package.path) then
		return require(modname)
	end
end

ALLOWED_KEYBOARDS = {}
request("hyprland.local")

require("hyprland.permissions")


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

-- Notify on submap activation
hl.on("keybinds.submap", function(submap)
	if CURRENT_SUBMAP_NOTIFICATION ~= nil then
		CURRENT_SUBMAP_NOTIFICATION:dismiss()
	end

	local text
	if string.len(submap) == 0 then
		text = "Reset submap"
	else
		text = "Activated submap: "..submap
	end
	CURRENT_SUBMAP_NOTIFICATION = hl.notification.create({ icon = "hint", text = text, timeout = 3e3 })
end)
