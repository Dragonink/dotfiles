for w = 1, 9 do
	local code = w + 9
	hl.bind("SUPER+code:"..code, hl.dsp.focus({ workspace = w }))
	hl.bind("SUPER+SHIFT+code:"..code, hl.dsp.window.move({ workspace = w, follow = false }))
end

hl.bind("SUPER+Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER+SHIFT+Tab", hl.dsp.focus({ workspace = "m-1" }))

hl.bind("SUPER+mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("SUPER+mouse_down", hl.dsp.focus({ workspace = "m-1" }))

for _, d in ipairs(DIRECTIONS) do
	local selector = DIRECTIONS.selector(d)

	hl.bind("SUPER+CONTROL+SHIFT+"..d, hl.dsp.workspace.move({ monitor = selector }))
end
