--- Loads the given module if it can be found.
---@param modname string
---@see require
---@diagnostic disable-next-line:lowercase-global
function require_optional(modname)
	if package.searchpath(modname, package.path) then
		return require(modname)
	end
end

require("hyprland.input")
require("hyprland.bindings")

-- Quickly configure unknown monitors
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
	cm = "auto",
})

hl.config({
	misc = {
		disable_autoreload = true,
		disable_splash_rendering = true,
	},
	ecosystem = {
		no_donation_nag = true,
	},
})

require_optional("hyprland.local")
