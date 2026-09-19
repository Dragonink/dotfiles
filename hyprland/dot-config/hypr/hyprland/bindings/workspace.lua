for _, workspace in ipairs(WORKSPACES) do
	hl.bind("SUPER+"..workspace.key, hl.dsp.focus({ workspace = workspace.index }), { description = "Focus workspace "..tostring(workspace) })
end
