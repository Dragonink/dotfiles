hl.bind("XF86MonBrightnessDown", hl.dsp.exec_raw("brightnessctl --class=backlight set 1%-"), { repeating = true, submap_universal = true, locked = true, description = "Decrease monitor brightness" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_raw("brightnessctl --class=backlight set +1%"), { repeating = true, submap_universal = true, locked = true, description = "Increase monitor brightness" })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_raw("wpctl set-volume --limit=1.0 @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true, submap_universal = true, locked = true, description = "Decrease audio volume" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_raw("wpctl set-volume --limit=1.0 @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true, submap_universal = true, locked = true, description = "Increase audio volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { submap_universal = true, locked = true, description = "Toggle deafen" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { submap_universal = true, locked = true, description = "Toggle mute" })
