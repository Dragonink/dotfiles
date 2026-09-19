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

---@class (exact) Workspace
---@field index integer
---@field key string
local Workspace = {}
--- Constructs a new workspace.
---@param workspace integer
---@return Workspace
local new_workspace = function(workspace)
	assert(workspace >= 1 and workspace <= 9)
	return setmetatable({
		index = workspace,
		key = "code:"..tostring(workspace + 9), -- NOTE: Code of key <1> is 10
	}, {
		__tostring = function (self)
			return tostring(self.index)
		end,
	})
end
---@type Workspace[]
WORKSPACES = {}
for workspace = 1, 9 do
	table.insert(WORKSPACES, new_workspace(workspace))
end
