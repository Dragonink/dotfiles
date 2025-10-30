pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import qs.components

Scope {
	id: root;

	required property PwNode node;

	PwObjectTracker {
		objects: [ root.node ];
	}

	Connections {
		target: root.node?.audio;

		function onVolumeChanged(): void {
			osd.show();
		}
	}

	OsdGauge {
		id: osd;

		value: root.node?.audio.volume ?? 0;
		icon: {
			let variant;
			if (this.value > 2/3) {
				variant = "high";
			} else if (this.value > 1/3) {
				variant = "medium";
			} else if (this.value > 0) {
				variant = "low";
			} else {
				variant = "muted";
			}
			return Quickshell.iconPath(`audio-volume-${variant}-symbolic`);
		}
	}
}
