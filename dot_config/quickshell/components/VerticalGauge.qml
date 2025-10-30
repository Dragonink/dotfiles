pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
	id: root;

	required property real value;

	anchors.fill: parent;

	radius: this.width * 2;
	color: "#50ffffff";

	Rectangle {
		anchors {
			bottom: parent.bottom;
			left: parent.left;
			right: parent.right;
		}
		implicitHeight: parent.height * root.value;
		

		radius: parent.radius;
	}
}
