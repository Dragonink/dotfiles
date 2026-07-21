hl.config({ ecosystem = { enforce_permissions = true } })

-- Deny unknown keyboards
for _, kb in ipairs(ALLOWED_KEYBOARDS) do
	hl.permission({ binary = kb, type = "keyboard", mode = "allow" })
end
if #ALLOWED_KEYBOARDS > 0 then
	hl.permission({ binary = ".*", type = "keyboard", mode = "deny" })
else
	hl.permission({ binary = ".*", type = "keyboard", mode = "allow" })
	hl.notification.create({ icon = "warning", font_size = 24, text = "All keyboards are allowed!\nDefine ALLOWED_KEYBOARDS in local.lua", timeout = 20e3 })
end
