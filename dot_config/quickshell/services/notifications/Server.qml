pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications

Singleton {
	NotificationServer {
		id: server;

		bodySupported: true;
		bodyMarkupSupported: true;

		onNotification: function(notification: Notification): void {
			notification.tracked = true;
		}
	}

	readonly property ObjectModel notifications: server.trackedNotifications;
}
