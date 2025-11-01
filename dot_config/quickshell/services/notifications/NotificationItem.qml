pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets

Rectangle {
	id: root;

	required property Notification modelData;

	readonly property string urgencyColor: {
		switch (this.modelData.urgency) {
			case NotificationUrgency.Low: return "#000000";
			case NotificationUrgency.Normal: return "#00ff00";
			case NotificationUrgency.Critical: return "#ff0000";
		}
	}

	implicitHeight: this.childrenRect.height;

	color: "#ffffff";
	border {
		width: 1;
		color: this.urgencyColor;
	}
	topLeftRadius: 5;
	bottomLeftRadius: this.topLeftRadius;

	Timer {
		id: expire;

		interval: {
			const timeout = root.modelData.expireTimeout;
			return timeout >= 0 ? timeout : 5000;
		}
		running: root.modelData.urgency !== NotificationUrgency.Critical;

		onTriggered: function(): void {
			root.modelData.expire();
		}
	}

	MouseArea {
		anchors {
			left: parent.left;
			right: parent.right;
		}
		implicitHeight: this.childrenRect.height;

		onClicked: function(event: MouseEvent): void {
			root.modelData.dismiss();
		}

		ColumnLayout {
			anchors {
				left: parent.left;
				right: parent.right;
			}

			RowLayout {
				Layout.fillWidth: true;

				IconImage {
					source: Quickshell.iconPath(root.modelData.appIcon, "image-missing");

					implicitSize: appName.height;
				}

				Text {
					id: appName;

					text: root.modelData.appName;
					textFormat: Text.PlainText;
					font.italic: true;
					elide: Text.ElideRight;

					Layout.fillWidth: true;
				}
			}

			Text {
				text: root.modelData.summary;
				textFormat: Text.StyledText;
				font.weight: Font.DemiBold;
				elide: Text.ElideRight;

				Layout.fillWidth: true;
			}

			Text {
				text: root.modelData.body;
				textFormat: Text.StyledText;
				wrapMode: Text.Wrap;

				Layout.fillWidth: true;
			}

			ProgressBar {
				id: progress;

				from: 0;
				to: expire.interval;
				value: this.to;

				Layout.fillWidth: true;
				implicitHeight: 10;

				NumberAnimation {
					target: progress;
					property: "value";
					from: progress.to;
					to: progress.from;

					running: expire.running;
					duration: expire.interval;
					easing.type: Easing.Linear;
				}

				background: Rectangle {
					anchors.fill: progress;

					color: "transparent";
				}

				contentItem: Item {
					anchors.fill: progress;

					Rectangle {
						anchors {
							top: parent.top;
							bottom: parent.bottom;
							right: parent.right;
						}
						implicitWidth: parent.width * progress.visualPosition;

						color: root.urgencyColor;
					}
				}
			}
		}
	}
}
