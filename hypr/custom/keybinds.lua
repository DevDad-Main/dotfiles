-- See https://wiki.hyprland.org/Configuring/Binds/

-- Edit config keybinds
hl.bind("CTRL + SUPER + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"), {description = "Edit shell config"})
hl.bind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit extra keybinds"})

-- Focusing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), {mouse = true, description = "Move"})
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), {mouse = true})
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), {mouse = true, description = "Resize"})

hl.bind("SUPER + H", hl.dsp.focus({direction = "l"}), {description = "Focus left"})
hl.bind("SUPER + L", hl.dsp.focus({direction = "r"}), {description = "Focus right"})
hl.bind("SUPER + K", hl.dsp.focus({direction = "u"}), {description = "Focus up"})
hl.bind("SUPER + J", hl.dsp.focus({direction = "d"}), {description = "Focus down"})
hl.bind("SUPER + BracketLeft", hl.dsp.focus({direction = "l"}), {description = "Focus left"})
hl.bind("SUPER + BracketRight", hl.dsp.focus({direction = "r"}), {description = "Focus right"})

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({direction = "l"}), {description = "Move window left"})
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({direction = "r"}), {description = "Move window right"})
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({direction = "u"}), {description = "Move window up"})
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({direction = "d"}), {description = "Move window down"})

hl.bind("ALT + F4", hl.dsp.window.close(), {description = "Close (Windows)"})
hl.bind("SUPER + Q", hl.dsp.window.close(), {description = "Close"})
hl.bind("SUPER + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), {description = "Forcefully zap a window"})
