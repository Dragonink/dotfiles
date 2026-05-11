local workspace_to_code = function(workspace)
	return workspace + 9
end

for w = 1, 9 do
	local code = workspace_to_code(w)
	hl.bind("SUPER+code:"..code, hl.dsp.focus({ workspace = w }))
	hl.bind("SUPER+SHIFT+code:"..code, hl.dsp.window.move({ workspace = w, follow = false }))
end

hl.bind("SUPER+Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER+SHIFT+Tab", hl.dsp.focus({ workspace = "m-1" }))

hl.bind("SUPER+mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER+mouse_down", hl.dsp.focus({ workspace = "m-1" }))

hl.define_submap("manage workspace", "reset", function()
	local current = hl.get_active_workspace()
	if current ~= nil then
		-- Rename workspace
		for w = 1, 9 do
			local code = workspace_to_code(w)
			hl.bind("code:"..code, hl.dsp.workspace.rename({ workspace = current, name = w }))
		end
		-- Move workspace
		for _, d in ipairs(DIRECTIONS) do
			local selector = DIRECTIONS.selector(d)
			hl.bind(d, hl.dsp.workspace.move({ monitor = selector }))
		end
	else
		hl.dispatch(hl.dsp.submap("reset"))
	end
	hl.bind("catchall", hl.dsp.submap("reset"))
end)
hl.bind("SUPER+SHIFT+W", hl.dsp.submap("manage workspace"))
