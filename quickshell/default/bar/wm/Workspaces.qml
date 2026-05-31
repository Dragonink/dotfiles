pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.data

WrapperItem {
	id: root;

	required property list<var> workspaces;
	property var monitor;

	ListView {
		id: list;

		model: ScriptModel {
			values: {
				root.workspaces
					.filter((workspace) => root.monitor == null || workspace.monitor?.id === root.monitor.id)
			}
			objectProp: "id";
		}
		currentIndex: {
			this.model
				.values
				.findIndex((workspace) => workspace.id === root.monitor?.activeWorkspace?.id)
		}
		orientation: ListView.Horizontal;
		spacing: 2;
		contentHeight: this.contentItem.childrenRect.height;
		implicitWidth: this.contentWidth;
		implicitHeight: this.contentHeight;

		delegate: WrapperRectangle {
			id: item;

			required property int index;
			required property var modelData;

			states: [
				State {
					name: "active";
					when: item.index === list.currentIndex;
					PropertyChanges { name {
						color: GlobalPalette.background;
					} }
				}
			]

			resizeChild: false;
			border {
				width: 1;
				color: GlobalPalette.foreground;
			}
			color: "transparent";
			radius: this.height / 2;
			implicitWidth: Math.max(this.height, this.child.implicitWidth);

			child: Text {
				id: name;

				text: item.modelData?.name ?? "?";
				textFormat: Text.PlainText;
				font.pixelSize: 10;
				font.weight: Font.DemiBold;
				color: GlobalPalette.foreground;
			}
		}
		highlight: Rectangle {
			color: GlobalPalette.foreground;
			radius: this.height / 2;
		}
	}
}
