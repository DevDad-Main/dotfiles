-- Put general config stuff here
-- Here's a list of every variable: https://wiki.hyprland.org/Configuring/Variables/

-- monitor=,addreserved, 0, 0, 0, 0 -- Custom reserved area
-- HDMI port: mirror display. To see device name, use `hyprctl monitors`

hl.monitor({
  output = "HDMI-A-5",
  mode = "1920x1080@60",
  position = "1920x0",
  scale = "1",
})

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 2,
    border_size = 2,
    col = {
      active_border = "rgba(e0af68ff)",
      inactive_border = "rgba(31313600)",
    },
  },
  decoration = {
    rounding = 18,
    active_opacity = 0.85,
    inactive_opacity = 0.90,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },
  },
  cursor = {
    no_hardware_cursors = true,
  },
})
