require("hyprland.bindings.define")

hl.bind("SUPER+Return", hl.dsp.exec_raw("app2unit -T"), { description = "Open new terminal" })
hl.bind("SUPER+Space", hl.dsp.exec_raw("fuzzel"), { description = "Open application launcher" })

for _, direction in pairs(DIRECTIONS) do
	hl.bind("SUPER+"..direction.key, hl.dsp.focus({ direction = direction.dispatch }), { description = "Move focus "..tostring(direction) })
end

require("hyprland.bindings.window")
