pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
	SystemClock {
		id: clock;

		precision: SystemClock.Seconds;
	}

	property alias date: clock.date;
	property alias hours: clock.hours;
	property alias minutes: clock.minutes;
	property alias seconds: clock.seconds;

	function format(format: var): string {
		return Qt.locale().toString(this.date, format);
	}
}
