pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
	exclusionMode: ExclusionMode.Ignore;
	anchors {
		right: true;
		top: true;
	}
	implicitWidth: 250;
	implicitHeight: layout.height;

	color: "transparent";

	ColumnLayout {
		id: layout;

		anchors {
			left: parent.left;
			right: parent.right;
		}
		implicitHeight: this.childrenRect.height;

		Repeater {
			model: Server.notifications;

			NotificationItem {
				Layout.fillWidth: true;
			}
		}
	}
}
