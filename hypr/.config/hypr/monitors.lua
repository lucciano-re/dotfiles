-- See https://wiki.hypr.land/Configuring/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors
-- hl.monitor({ output, mode, position, scale })

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- hl.env("GDK_SCALE", "2")
-- hl.monitor({ output = "*", mode = "preferred", position = "auto", scale = "auto" })

-- output = "*" mirrors the classic `monitor=,...` fallback (matches any monitor
-- not covered by a more specific hl.monitor() call)
hl.monitor({ output = "*", mode = "1920x1080@180", position = "auto", scale = "auto" })

-- Good compromise for 27" or 32" 4K monitors (but fractional!)
-- hl.env("GDK_SCALE", "1.75")
-- hl.monitor({ output = "*", mode = "preferred", position = "auto", scale = 1.6 })

-- Straight 1x setup for low-resolution displays like 1080p or 1440p
-- hl.env("GDK_SCALE", "1")
-- hl.monitor({ output = "*", mode = "preferred", position = "auto", scale = 1 })

-- Example for Framework 13 w/ 6K XDR Apple display
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })
