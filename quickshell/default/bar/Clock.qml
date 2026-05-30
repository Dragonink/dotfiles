pragma ComponentBehavior: Bound

import QtQuick
import qs.data

Text {
	text: {
		const EN = '\u2002';
		const EM = '\u2003';
		return DateTime.format(`ddd${EN}dd MMM yyyy${EM}hh:mm:ss${EN}t`);
	}
	textFormat: Text.PlainText;
	font.family: "DSEG14 Modern";
	font.weight: Font.DemiBold;
	color: GlobalPalette.foreground;
	horizontalAlignment: Text.AlignHCenter;
	verticalAlignment: Text.AlignVCenter;
	anchors {
		centerIn: parent;
		alignWhenCentered: false;
	}
}
