local LMB = "mouse:272"
local RMB = "mouse:273"


hl.bind("SUPER+Q", hl.dsp.window.close(), { description = "Close window" })

hl.bind("SUPER+F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle", description = "Toggle fullscreen" }))

for _, direction in ipairs(Directions) do
	local selector = Directions.selector(direction)
	hl.bind("SUPER+"..direction, hl.dsp.focus({ direction = selector }), { description = "Move focus "..direction })
	hl.bind("SUPER+SHIFT+"..direction, hl.dsp.window.move({ direction = selector }), { description = "Move window "..direction })
end

hl.define_submap("window resize", function()
	local OFFSET = 1
	local OFFSETS = {
		left = { x = -OFFSET },
		right = { x = OFFSET },
		up = { y = -OFFSET },
		down = { y = OFFSET },
	}
	for _, direction in ipairs(Directions) do
		local params = { x = 0, y = 0, relative = true }
		for k, v in pairs(OFFSETS[direction]) do params[k] = v end
		hl.bind(direction, hl.dsp.window.resize(params), { repeating = true })
	end
	hl.bind("Escape", hl.dsp.submap("reset"), { description = "Leave window resize mode" })
end)
hl.bind("SUPER+R", hl.dsp.submap("window resize"), { description = "Enter window resize mode" })

hl.bind("SUPER+"..LMB, hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER+"..RMB, hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
