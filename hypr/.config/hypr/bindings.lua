-- Application bindings
hl.bind("SUPER + Return", hl.dsp.exec_cmd('uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"'), { description = "Terminal" })
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("omarchy-launch-browser"), { description = "Browser" })
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"), { description = "File manager" })
hl.bind("SUPER + ALT + SHIFT + F", hl.dsp.exec_cmd('uwsm-app -- nautilus --new-window "$(omarchy-cmd-terminal-cwd)"'), { description = "File manager (cwd)" })
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("omarchy-launch-browser"), { description = "Browser" })
hl.bind("SUPER + SHIFT + ALT + B", hl.dsp.exec_cmd("omarchy-launch-browser --private"), { description = "Browser (private)" })
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("omarchy-launch-editor"), { description = "Editor" })

-- Add extra bindings
-- hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd('omarchy-launch-webapp "https://chatgpt.com"'), { description = "ChatGPT" })
-- hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("alacritty -e ssh your-server"))

-- Replace mako with swaync
hl.unbind("SUPER + comma")
hl.unbind("SUPER + ALT + comma")
hl.unbind("SUPER + CTRL + comma")
hl.unbind("SUPER + SHIFT + comma")
hl.unbind("SUPER + SHIFT + ALT + comma")

hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { description = "Open Swaync" })
hl.bind("SUPER + comma", hl.dsp.exec_cmd("swaync-client -C"), { description = "Dismiss last notification" })
hl.bind("SUPER + ALT + comma", hl.dsp.exec_cmd("swaync-client -i"), { description = "Invoke last notification" })
hl.bind("SUPER + CTRL + comma", hl.dsp.exec_cmd("swaync-client -d"), { description = "Toggle silencing notifications" })
hl.bind("SUPER + SHIFT + comma", hl.dsp.exec_cmd("swaync-client -c"), { description = "Dismiss all notifications" })
hl.bind("SUPER + SHIFT + ALT + comma", hl.dsp.exec_cmd("swaync-client -R"), { description = "Restore last notification" })

-- Overwrite existing bindings, like putting Omarchy Menu on Super + Space
-- hl.unbind("SUPER + space")
-- hl.bind("SUPER + space", hl.dsp.exec_cmd("omarchy-menu"), { description = "Omarchy menu" })

hl.unbind("SUPER + SHIFT + X") -- Twitter
hl.unbind("SUPER + SHIFT + ALT + X") -- Twitter
hl.unbind("SUPER + SHIFT + CTRL + G") -- sabra dios
hl.unbind("SUPER + SHIFT + W")
hl.unbind("SUPER + SHIFT + G")

hl.unbind("SUPER + SHIFT + A") -- chatgpt
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd('omarchy-launch-webapp "https://gemini.google.com"'), { description = "Gemini" })

hl.unbind("SUPER + SHIFT + ALT + A") -- gemini
hl.bind("SUPER + SHIFT + ALT + A", hl.dsp.exec_cmd('omarchy-launch-webapp "https://claude.ai"'), { description = "Claude" })

hl.unbind("SUPER + SHIFT + C") -- calendar
hl.bind("SUPER + SHIFT + ALT + C", hl.dsp.exec_cmd('omarchy-launch-webapp "https://calendar.google.com"'), { description = "Calendar" })

hl.unbind("SUPER + SHIFT + E") -- email
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd('omarchy-launch-webapp "https://gmail.com"'), { description = "Email" })

hl.unbind("SUPER + SHIFT + S") -- windows-like
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("omarchy-capture-screenshot"), { description = "Screenshot with editing" }) -- windows-screenshot
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("omarchy-capture-text-extraction"), { description = "Extract text" }) -- windows-screenshot
hl.env("OMARCHY_SCREENSHOT_DIR", "/home/lucho/Pictures/Screenshots")

-- ⚠️ TODO: $key / $reverse aren't defined anywhere in this file — in the classic config
-- these only worked if hyprswitch's own setup step substituted real key names in for you.
-- Confirm with hyprswitch's docs how it wants these expressed under the Lua config
-- before relying on them; as translated they'll fail since $key/$reverse are undefined.
hl.bind("ALT + $key", hl.dsp.exec_cmd("hyprswitch gui --mod-key alt_l --key $key --close mod-key-release --reverse-key=mod=$reverse && hyprswitch dispatch"))
hl.bind("ALT + $reverse + $key", hl.dsp.exec_cmd("hyprswitch gui --mod-key alt_l --key $key --close mod-key-release --reverse-key=mod=$reverse && hyprswitch dispatch -r"))

hl.unbind("SUPER + SHIFT + ALT + S")
hl.bind("SUPER + SHIFT + ALT + S", hl.dsp.exec_cmd("omarchy-cmd-screenshot smart clipboard"), { description = "Screenshot to clipboard" })

hl.bind("CTRL + Tab", hl.dsp.exec_cmd("rofi -show window"), { description = "Rofi" })

hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("obsidian"), { description = "Obsidian" })

hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("spotify"), { description = "Spotify" })

hl.bind("SUPER + SHIFT + CTRL + S", hl.dsp.exec_cmd("omarchy-menu screenrecord"), { description = "Screenrecording" })

hl.bind("SUPER + CTRL + P", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })

hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("gnome-calculator"), { description = "Calculator" })

-- bind brightness
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("~/.config/waybar/scripts/brightness-control.sh up"), { description = "Brightness up" })
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("~/.config/waybar/scripts/brightness-control.sh down"), { description = "Brightness down" })

-- Cambiar seguridad para no cerrar programas
hl.unbind("SUPER + W")
hl.bind("SUPER + SHIFT + W", hl.dsp.window.close(), { description = "Close window" })
hl.bind("SUPER + CTRL + SHIFT + W", hl.dsp.exec_cmd([[kill -9 $(hyprctl activewindow -j | jq '.pid')]]), { description = "Killactive Window" })

-- Subir y bajar volumen
hl.unbind("SUPER + CTRL + l") -- Lock system
hl.unbind("SUPER + CTRL + k")

hl.bind("SUPER + CTRL + l", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { description = "Subir Volumen" })
hl.bind("SUPER + CTRL + k", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { description = "Bajar Volumen" })
