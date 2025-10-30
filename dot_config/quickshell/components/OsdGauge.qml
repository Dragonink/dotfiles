pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import qs.components

Scope {
	id: root;

	required property real value;
	required property string icon;

	Timer {
		id: hide;

		interval: 1000;
		onTriggered: {
			root.hide();
		}
	}

	function show(): void {
		lazy.active = true;
		hide.restart();
	}
	function hide(): void {
		lazy.active = false;
	}

	LazyLoader {
		id: lazy;

		PanelWindow {
			exclusionMode: ExclusionMode.Ignore;
			anchors.right: true;
			implicitHeight: 300;
			implicitWidth: 50;

			color: "transparent";
			mask: Region {}

			Rectangle {
				anchors.fill: parent;

				topLeftRadius: this.width / 2;
				bottomLeftRadius: this.width / 2;
				color: "#80ffffff";

				ColumnLayout {
					anchors {
						fill: parent;
						topMargin: 10;
						bottomMargin: 10;
					}

					IconImage {
						source: root.icon;
						implicitSize: 30;

						Layout.alignment: Qt.AlignCenter;
					}

					VerticalGauge {
						value: root.value;

						Layout.alignment: Qt.AlignCenter;
						Layout.fillHeight: true;
						implicitWidth: 20;
					}

					Text {
						text: `${Math.round(root.value * 100)}%`;

						Layout.alignment: Qt.AlignCenter;
					}
				}
			}
		}
	}
}
