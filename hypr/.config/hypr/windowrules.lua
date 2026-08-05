-- hl.window_rule({ match = { class = "qemu" }, workspace = "1" })

hl.window_rule({ match = { class = "com.luchho.weather" }, float = true, size = { 953, 700 } })
hl.window_rule({ match = { class = "tui-notepad" }, float = true, size = { 950, 700 } })

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, ignore_alpha = 0.5 })
