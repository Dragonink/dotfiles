pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.data

PanelWindow {
	id: root;

	property list<Item> left_widgets: [];
	property list<Item> right_widgets: [];
	property int margin: 5;

	anchors {
		left: true;
		right: true;
	}
	margins {
		left: this.margin;
		right: this.margin;
		top: this.margin;
		bottom: this.margin;
	}
	color: "transparent";

	RowLayout {
		anchors.fill: parent;

		component Widget: WrapperRectangle {
			id: widget;

			required property Item modelData;

			resizeChild: false;
			leftMargin: this.height / 3;
			rightMargin: this.height / 3;
			color: GlobalPalette.transparentBackground;
			radius: this.height / 2;
			Layout.fillHeight: true;

			child: this.modelData;
		}

		Repeater {
			model: root.left_widgets;

			Widget {
				Layout.alignment: Qt.AlignLeft;
			}
		}
		Repeater {
			model: root.right_widgets;

			Widget {
				Layout.alignment: Qt.AlignRight;
			}
		}
	}
}
