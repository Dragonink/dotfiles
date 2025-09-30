pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.bar.modules

Variants {
	model: Quickshell.screens;

	PanelWindow {
		required property ShellScreen modelData;
		screen: this.modelData;

		anchors {
			left: true;
			top: true;
			bottom: true;
		}
		implicitWidth: 40;
		color: "#cc212121";

		ColumnLayout {
			// anchors.fill: this.parent;

			Clock {
				Layout.alignment: Qt.AlignHCenter;
			}
		}
	}
}
