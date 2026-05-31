pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

WrapperItem {
	id: root;

	property ShellScreen screen;

	RowLayout {
		Workspaces {
			workspaces: Hyprland.workspaces.values;
			monitor: Hyprland.monitorFor(root.screen);
		}
	}

	Component.onCompleted: function() {
		// local gaps_out = hl.get_config("general.gaps_out")
		// gaps_out.bottom = Bar.margin
		// hl.config({ general = { gaps_out = gaps_out } })
	}
	Component.onDestruction: function() {}
}
