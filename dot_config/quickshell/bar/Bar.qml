pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
	id: root;

	required property ShellScreen modelData;

	screen: modelData;
	anchors {
		bottom: true;
		left: true;
		right: true;
	}
	implicitHeight: 20;

	color: "transparent";

	RowLayout {
		anchors.fill: parent;

		Workspaces {
			screen: root.screen;

			Layout.alignment: Qt.AlignVCenter;
		}

		Clock {}
	}
}
