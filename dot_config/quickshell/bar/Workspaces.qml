pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
	id: root;

	required property ShellScreen screen;
	readonly property HyprlandMonitor monitor: Hyprland.monitorFor(this.screen);

	Repeater {
		model: {
			Hyprland.workspaces
				.values
				.filter(workspace => workspace.monitor?.id === root.monitor.id)
		}

		RoundButton {
			id: workspace;

			required property HyprlandWorkspace modelData;

			Layout.alignment: Qt.AlignVCenter;
			implicitHeight: 14;
			implicitWidth: this.height * (workspace.modelData?.active ? 2.5 : 1);

			flat: true;
			background: Rectangle {
				color: workspace.modelData?.active ? "#ffffff": "#888888";
				radius: this.height / 2;
			}
			contentItem: Text {
				text: workspace.modelData?.id ?? "";

				font.pixelSize: workspace.height - 4;
				horizontalAlignment: Text.AlignHCenter;
				verticalAlignment: Text.AlignVCenter;
			}

			onClicked: {
				workspace.modelData.activate();
			}
		}
	}
}
