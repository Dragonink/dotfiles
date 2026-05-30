pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
	SystemPalette {
		id: active;

		colorGroup: SystemPalette.Active;
	}

	property alias foreground: active.windowText;
	property alias background: active.window;
	readonly property color transparentBackground: {
		const COLOR = this.background;
		Qt.rgba(COLOR.r, COLOR.g, COLOR.b, 0.50)
	}
}
