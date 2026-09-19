---@class (exact) Direction
---@field private display string
---@field dispatch string
---@field key string
local Direction = {}
--- Constructs a new direction.
---@param direction string
---@return Direction
local new_direction = function(direction)
	local display = direction:lower()
	return setmetatable({
		key = direction,
		display = display,
		dispatch = display:sub(1, 1),
	}, {
		__tostring = function (self)
			return self.display
		end,
	})
end
---@enum Directions
DIRECTIONS = {
	LEFT = new_direction("Left"),
	DOWN = new_direction("Down"),
	UP = new_direction("Up"),
	RIGHT = new_direction("Right"),
}
