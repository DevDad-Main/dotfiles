-- You can put custom rules here
-- Window/layer rules: https://wiki.hyprland.org/Configuring/Window-Rules/
-- Workspace rules: https://wiki.hyprland.org/Configuring/Workspace-Rules/

-- ######## Window rules ########

-- Uncomment to apply global transparency to all windows:
-- hl.window_rule({ match = { class = ".*" }, opacity = 0.89, active_opacity = 0.89 })

-- Disable blur for all xwayland apps
-- hl.window_rule({match = {xwayland = 1}, no_blur = true})

-- Set opacity to 1.0 active, 0.5 inactive and 0.8 fullscreen for zen or any others
hl.window_rule({
  match = { class = "zen" },
  opacity = "1 override 1 override 1 override",
})
