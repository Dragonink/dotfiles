pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
	SystemPalette {
		id: palette;

		colorGroup: SystemPalette.Active;
	}

	ColumnLayout {
		anchors.fill: this.parent;

		Text {
			text: ClockData.format("hh");
			font.family: "monospace";
			font.bold: true;
			color: palette.windowText;
		}
		Text {
			text: ClockData.format("mm");

			font.family: "monospace";
			font.bold: true;
			color: palette.windowText;
		}
		Text {
			text: ClockData.format("ss");

			font.family: "monospace";
			color: palette.windowText;
		}
	}
}
