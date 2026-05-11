local LMB = "mouse:272"


hl.bind("SUPER+Q", hl.dsp.window.close())

hl.bind("SUPER+F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

for _, d in ipairs(DIRECTIONS) do
	local selector = DIRECTIONS.selector(d)

	hl.bind("SUPER+"..d, hl.dsp.focus({ direction = selector }))
	hl.bind("SUPER+SHIFT+"..d, hl.dsp.window.move({ direction = selector }))
end

hl.define_submap("resize", function()
	local OFFSET = 1
	local OFFSETS = {
		left = { x = -OFFSET },
		right = { x = OFFSET },
		down = { y = -OFFSET },
		up = { y = OFFSET },
	}

	for _, d in ipairs(DIRECTIONS) do
		local params = { x = 0, y = 0, relative = true }
		for k, v in pairs(OFFSETS[d]) do params[k] = v end

		hl.bind(d, hl.dsp.window.resize(params), { repeating = true })
	end

	hl.bind("Escape", hl.dsp.submap("reset"))
end)
hl.bind("SUPER+R", hl.dsp.submap("resize"))

hl.bind("SUPER+"..LMB, hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER+CONTROL+"..LMB, hl.dsp.window.resize(), { mouse = true })
