local workspace_to_code = function(workspace)
	return workspace + 9
end

for w = 1, 9 do
	local code = workspace_to_code(w)
	hl.bind("SUPER+code:"..code, hl.dsp.focus({ workspace = w }), { description = "Activate workspace "..w })
	hl.bind("SUPER+SHIFT+code:"..code, hl.dsp.window.move({ workspace = w, follow = false }), { description = "Move window to workspace "..w })
end

hl.bind("SUPER+Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Activate next workspace" })
hl.bind("SUPER+SHIFT+Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Activate previous workspace" })

hl.bind("SUPER+mouse_up", hl.dsp.focus({ workspace = "m+1" }), { description = "Activate next workspace" })
hl.bind("SUPER+mouse_down", hl.dsp.focus({ workspace = "m-1" }), { description = "Activate previous workspace" })

hl.define_submap("manage workspace", "reset", function()
	-- Move workspace
	for _, direction in ipairs(Directions) do
		local selector = Directions.selector(direction)
		hl.bind(direction, hl.dsp.workspace.move({ monitor = selector }), { description = "Move workspace "..direction })
	end
	hl.bind("catchall", hl.dsp.submap("reset"), { description = "Leave workspace management mode" })
end)
hl.bind("SUPER+SHIFT+W", hl.dsp.submap("manage workspace"), { description = "Enter workspace management mode" })
