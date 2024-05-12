-- Show symlink in status bar
function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end

	return ui.Span(" " .. h.name .. linked)
end

-- Show user and group owners of files in status bar
function Status:owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line {}
	else
		return ui.Line {
			ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("yellow"),
			ui.Span(":"),
			ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("yellow"),
			ui.Span(" "),
		}
	end
end

function Status:render(area)
	self.area = area

	local left = ui.Line {
		self:mode(),
		self:size(),
		self:name(),
	}
	local right = ui.Line {
		-- Show user and group owners of files in status bar
		self:owner(),
		self:permissions(),
		self:percentage(),
		self:position(),
	}
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end
