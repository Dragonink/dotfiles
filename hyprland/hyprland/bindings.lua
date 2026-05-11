DIRECTIONS = {
	"left", "down", "up", "right",

	selector = function(d)
		return string.sub(d, 1, 1)
	end,
}


-- Applications
hl.bind("SUPER+Return", hl.dsp.exec_raw("app2unit -T"), { description = "Open new terminal" })
hl.bind("SUPER+Space", hl.dsp.exec_raw("fuzzel"), { description = "Open application launcher" })

-- Screenshot
hl.bind("Print", function()
	local grim = { "grim" }
	local monitor = hl.get_active_monitor()
	if monitor then
		table.insert(grim, "-o")
		table.insert(grim, monitor.name)
	end
	table.insert(grim, "-")

	hl.dispatch(hl.dsp.exec_cmd(table.concat(grim, " ").." | wl-copy"))
end, { submap_universal = true, description = "Take screenshot of active monitor" })
hl.bind("CONTROL+Print", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"), { submap_universal = true, description = "Take screenshot of region" })

-- Session
hl.bind("SUPER+L", hl.dsp.exec_raw("loginctl lock-session"), { description = "Lock session" })


require("hyprland.bindings.window")
require("hyprland.bindings.workspace")
require("hyprland.bindings.media_keys")
