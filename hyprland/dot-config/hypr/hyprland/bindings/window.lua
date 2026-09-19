hl.bind("SUPER+Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind("SUPER+SHIFT+Q", hl.dsp.window.kill(), { description = "Kill window" })

for _, direction in pairs(DIRECTIONS) do
	hl.bind("SUPER+SHIFT+"..direction.key, hl.dsp.window.move({ direction = direction.dispatch }), { description = "Move window "..tostring(direction) })
end
hl.bind("SUPER+"..LMB, hl.dsp.window.drag(), { mouse = true, description = "Drag window" })

for _, workspace in ipairs(WORKSPACES) do
	hl.bind("SUPER+SHIFT+"..workspace.key, hl.dsp.window.move({ workspace = workspace.index, follow = false }), { description = "Move window to workspace "..tostring(workspace) })
end

hl.bind("SUPER+F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }), { description = "Toggle fullscreen" })
