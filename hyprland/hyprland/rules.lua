-- Game windows
for _, rule in ipairs({
	{
		name = "gamescope",
		match = {
			initial_class = "^gamescope$",
		},
	},
	{
		name = "steam-proton",
		match = {
			initial_class = "^steam_app_\\d+$",
		},
	}
}) do
	hl.window_rule({
		name = rule.name,
		match = rule.match,
		content = "game",
	})
end
hl.window_rule({
	name = "tear-games",
	match = {
		content = "game",
	},
	immediate = true,
})
