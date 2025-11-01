pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire

import qs.bar
import qs.menus as Menus
import qs.osd as Osd
import qs.services as Services

ShellRoot {
	settings.watchFiles: true;

	Variants {
		model: Quickshell.screens;

		Bar {}
	}

	Menus.PowerMenu {}

	Osd.Volume {
		node: Pipewire.defaultAudioSink;
	}
	Osd.Brightness {
		device: "amdgpu_bl2";
	}

	Services.Notifications {}
}
