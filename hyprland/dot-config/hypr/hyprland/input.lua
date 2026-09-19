--- Queries `/org/freedesktop/locale1` DBus interface, returning the value of the given property.
---@param property string
local query_locale = function(property)
	local pipe = io.popen("dbus-send --system --print-reply=literal --dest=org.freedesktop.locale1 /org/freedesktop/locale1 org.freedesktop.DBus.Properties.Get string:org.freedesktop.locale1 string:"..property, "r")
	if not pipe then
		error("Failed to execute dbus-send")
	end

	---@type string
	local output = pipe:read("a")
	pipe:close()

	---@type string|nil
	local ret = output:match("%s*variant%s+(%S*)$")
	if ret ~= nil and ret ~= '' then
		return ret
	else
		return nil
	end
end

hl.config({
	input = {
		kb_layout = query_locale("X11Layout"),
		kb_model = query_locale("X11Model"),
		kb_variant = query_locale("X11Variant"),
		kb_options = query_locale("X11Options"),
		numlock_by_default = true,
	},
})
