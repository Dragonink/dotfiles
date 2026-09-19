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

hl.bind("Print", hl.dsp.exec_cmd("grim - | satty --copy-command=wl-copy --filename=- --output-filename='"..(os.getenv("XDG_PICTURES_DIR") or "~/Pictures").."/Screenshots/%+.png'"), { submap_universal = true, description = "Take screenshot" })

require("hyprland.bindings.window")
require("hyprland.bindings.workspace")
require("hyprland.bindings.media_keys")
