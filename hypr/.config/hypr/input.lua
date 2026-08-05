-- Control your input devices
-- See https://wiki.hypr.land/Configuring/Variables/#input

hl.config({
    input = {
        kb_options = "compose:caps",
        kb_layout = "latam",
        repeat_rate = 40,
        repeat_delay = 600,
        numlock_by_default = true,
        sensitivity = -1,
    },
})

-- Scroll nicely in the terminal
hl.window_rule({ match = { class = "Alacritty|kitty" }, scroll_touchpad = 1.5 })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, scroll_touchpad = 0.2 })

-- mouse cursor
hl.env("XCURSOR_THEME", "volantes_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor volantes_cursors 24")
end)

-- Enable touchpad gestures for changing workspaces
-- See https://wiki.hyprland.org/Configuring/Gestures/
-- hl.config({ gestures = { workspace_swipe = true } })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout)
-- hl.bind("gesture:3:left", hl.dsp.focus({ direction = "l" }))
-- hl.bind("gesture:3:right", hl.dsp.focus({ direction = "r" }))
