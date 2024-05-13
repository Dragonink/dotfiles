local function entry(st, args)
	local current = cx.active.current
	local new = (current.cursor + args[1]) % #current.files

	ya.manager_emit("arrow", { new - current.cursor })
end

return { entry = entry }
