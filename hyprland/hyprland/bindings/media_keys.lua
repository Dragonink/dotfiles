-- Screen Backlight
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_raw("brightnessctl --class=backlight set 1%-"), { repeating = true, locked = true, submap_universal = true, description = "Decrease screen brightness" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_raw("brightnessctl --class=backlight set +1%"), { repeating = true, locked = true, submap_universal = true, description = "Increase screen brightness" })

-- Audio Volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_raw("wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 1%-"), { repeating = true, locked = true, submap_universal = true, description = "Decrease volume" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_raw("wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 1%+"), { repeating = true, locked = true, submap_universal = true, description = "Increase volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, submap_universal = true, description = "Toggle deafen" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, submap_universal = true, description = "Toggle mute" })

-- Media Player
hl.bind("XF86AudioPlay", hl.dsp.exec_raw("playerctl play-pause"), { locked = true, submap_universal = true, description = "Play/pause media" })
hl.bind("XF86AudioPause", hl.dsp.exec_raw("playerctl pause"), { locked = true, submap_universal = true, description = "Pause media" })
hl.bind("XF86AudioStop", hl.dsp.exec_raw("playerctl stop"), { locked = true, submap_universal = true, description = "Stop media" })
hl.bind("XF86AudioPrev", hl.dsp.exec_raw("playerctl previous"), { locked = true, submap_universal = true, description = "Play previous media" })
hl.bind("XF86AudioNext", hl.dsp.exec_raw("playerctl next"), { locked = true, submap_universal = true, description = "Play next media" })
