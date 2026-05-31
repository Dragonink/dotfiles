//@ pragma RespectSystemStyle
//@ pragma NativeTextRendering
//@ pragma DropExpensiveFonts
pragma ComponentBehavior: Bound

import Quickshell
import qs.bar

ShellRoot {
	settings.watchFiles: false;

	Variants {
		model: Quickshell.screens;

		Scope {
			property alias modelData: bar.screen;

			Bar {
				id: bar;

				anchors.bottom: true;
				implicitHeight: 25;

				left_widgets: [
					WM {
						screen: bar.screen;
					},
				]
				right_widgets: [
					Clock {},
				]
			}
		}
	}
}
