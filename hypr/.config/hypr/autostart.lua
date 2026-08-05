-- Extra autostart processes
-- hl.on("hyprland.start", function() hl.exec_cmd("my-service") end)

-- keyring fix
-- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

-- gpu crash
-- Environment variables for Aquamarine backend
hl.env("AQ_DRM_NO_EXPLICIT_SYNC", "1")
hl.env("AQ_NO_HARDWARE_CURSORS", "1")

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("omarchy-toggle-nightlight")
    hl.exec_cmd("swaync")

    -- change mouse cursor
    hl.exec_cmd("hyprctl setcursor volantes_cursors 28")
    hl.exec_cmd("otd-daemon")

    -- spawn silently into the M scratchpad instead of the active workspace
    hl.exec_cmd("spotify", { workspace = "special:scratchpadM silent" })

    hl.exec_cmd("kitty")
    hl.exec_cmd("mpd")

    -- hl.exec_cmd("protonvpn-app")
end)
