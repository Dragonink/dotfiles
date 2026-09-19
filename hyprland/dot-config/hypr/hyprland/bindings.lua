require("hyprland.bindings.define")

--- Key code for the Left Mouse Button
LMB = "mouse:272"
--- Key code for the Right Mouse Button
RMB = "mouse:273"

hl.bind("SUPER+Return", hl.dsp.exec_raw("app2unit -T"), { description = "Open new terminal" })
hl.bind("SUPER+Space", hl.dsp.exec_raw("fuzzel"), { description = "Open application launcher" })

for _, direction in pairs(DIRECTIONS) do
	hl.bind("SUPER+"..direction.key, hl.dsp.focus({ direction = direction.dispatch }), { description = "Move focus "..tostring(direction) })
end

require("hyprland.bindings.window")
