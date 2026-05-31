pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets

WrapperItem {
	id: root;

	property ShellScreen screen;

	Loader {
		sourceComponent: {
			switch (Quickshell.env("XDG_SESSION_DESKTOP")) {
			}
		}
	}
}
