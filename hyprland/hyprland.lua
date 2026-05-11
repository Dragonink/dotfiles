require("hyprland.layout")
require("hyprland.decorations")
require("hyprland.input")
require("hyprland.bindings")

function request(modname)
	if package.searchpath(modname, package.path) then
		return require(modname)
	end
end

ALLOWED_KEYBOARDS = {}
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

-- PERMISSIONS
hl.config({ ecosystem = { enforce_permissions = true } })
-- Bypass XDG Desktop Portal for screen copy
hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprlock", type = "screencopy", mode = "allow" })
-- Deny unknown keyboards
for _, kb in ipairs(ALLOWED_KEYBOARDS) do
	hl.permission({ binary = kb, type = "keyboard", mode = "allow" })
end
if #ALLOWED_KEYBOARDS > 0 then
	hl.permission({ binary = ".*", type = "keyboard", mode = "deny" })
else
	hl.permission({ binary = ".*", type = "keyboard", mode = "allow" })
	hl.notification.create({ icon = 0, duration = 10e3, text = "All keyboards are allowed! Define ALLOWED_KEYBOARDS in local.lua" })
end
