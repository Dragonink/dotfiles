import Quickshell
import Quickshell.Services.Pipewire

import qs.bar
import qs.osd

ShellRoot {
	settings.watchFiles: true;

	Variants {
		model: Quickshell.screens;

		Bar {}
	}

	Volume {
		node: Pipewire.defaultAudioSink;
	}
	Brightness {
		device: "amdgpu_bl2";
	}
}
