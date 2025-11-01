pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
	SystemClock {
		id: clock;

		precision: SystemClock.Seconds;
	}

	readonly property string display: {
		Qt.formatDateTime(clock.date, Qt.locale(), Locale.FormatType.LongFormat)
	}
}
