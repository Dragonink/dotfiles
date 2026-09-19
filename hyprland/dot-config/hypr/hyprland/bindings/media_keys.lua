hl.bind("XF86MonBrightnessDown", hl.dsp.exec_raw("brightnessctl --class=backlight set 1%-"), { repeating = true, submap_universal = true, locked = true, description = "Decrease monitor brightness" })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_raw("brightnessctl --class=backlight set +1%"), { repeating = true, submap_universal = true, locked = true, description = "Increase monitor brightness" })
