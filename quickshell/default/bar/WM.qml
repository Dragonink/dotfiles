pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.bar.wm

WrapperItem {
	id: root;

	property ShellScreen screen;

	Loader {
		sourceComponent: {
			switch (Quickshell.env("XDG_SESSION_DESKTOP")) {
				case "Hyprland": return hyprland;
			}
		}
	}

	Component {
		id: hyprland;

		Hyprland {
			screen: root.screen;
		}
	}
}
