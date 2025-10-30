pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

import qs.components

Scope {
	id: root;

	required property string device;

	FileView {
		id: brightness;

		path: `/sys/class/backlight/${root.device}/brightness`;
		watchChanges: true;
		onFileChanged: {
			this.reload();
			osd.show();
		}
	}
	readonly property int brightness: {
		parseInt(brightness.text())
	}

	FileView {
		id: maxBrightness;

		path: `/sys/class/backlight/${root.device}/max_brightness`;
		watchChanges: true;
		onFileChanged: {
			this.reload();
		}
	}
	readonly property int maxBrightness: {
		parseInt(maxBrightness.text())
	}

	OsdGauge {
		id: osd;

		value: root.brightness / root.maxBrightness;
		icon: Quickshell.iconPath(`display-brightness-symbolic`);
	}
}
