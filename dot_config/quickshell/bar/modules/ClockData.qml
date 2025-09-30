pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
	readonly property var datetime: clock.date;

	function format(format: string): string {
		return Qt.formatDateTime(this.datetime, format);
	}

	SystemClock {
		id: clock;

		precision: SystemClock.Seconds;
	}
}
