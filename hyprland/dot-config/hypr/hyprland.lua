--- Loads the given module if it can be found.
---@param modname string
---@see require
---@diagnostic disable-next-line:lowercase-global
function require_optional(modname)
	if package.searchpath(modname, package.path) then
		return require(modname)
	end
end

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
