pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

LazyLoader {
	id: lazy;

	active: false;

	PanelWindow {
		exclusionMode: ExclusionMode.Ignore;
		anchors.top: true;
		implicitWidth: 600;
		implicitHeight: 200;

		color: "transparent";

		Rectangle {
			anchors.fill: parent;

			bottomLeftRadius: 20;
			bottomRightRadius: this.bottomLeftRadius;

			RowLayout {
				anchors.fill: parent;

				Repeater {
					model: [
						{ icon: "system-shutdown-symbolic", command: ["systemctl", "poweroff"], },
						{ icon: "system-reboot-symbolic", command: ["systemctl", "reboot"], },
						{ icon: "system-lock-screen-symbolic", command: ["loginctl", "lock-session"], },
					];

					RoundButton {
						id: control;

						required property var modelData;

						Layout.alignment: Qt.AlignCenter;
						implicitHeight: parent.height * 2 / 3;
						implicitWidth: this.height;

						contentItem: IconImage {
							source: Quickshell.iconPath(control.modelData.icon);
						}

						onClicked: {
							lazy.active = false;
							Quickshell.execDetached(control.modelData.command);
						}
					}
				}
			}
		}
	}
}
