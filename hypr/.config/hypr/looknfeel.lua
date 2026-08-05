-- Change the default Omarchy look'n'feel

-- https://wiki.hyprland.org/Configuring/Variables/#general
-- https://wiki.hyprland.org/Configuring/Variables/#decoration
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 2,

        -- Change to niri-like side-scrolling layout
        -- layout = "scrolling",
    },
    decoration = {
        -- Use round window corners
        rounding = 12,

        -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed)
        dim_inactive = true,
        dim_strength = 0.0,
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#animations
-- Disable all animations
-- hl.config({ animations = { enabled = false } })

-- https://wiki.hypr.land/Configuring/Variables/#layout
-- Avoid overly wide single-window layouts on wide screens
-- hl.config({ layout = { single_window_aspect_ratio = "1 1" } })
