-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- 旧: env = NAME,VALUE  →  hl.env("NAME", "VALUE")
-- 元の envs.conf は全てコメントアウトされていたため、ここでも全てコメントアウトのまま移植しています。

-- hl.env("XCURSOR_SIZE", "32")

-- hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("GTK_THEME", "Adwaita:dark")
-- hl.env("MOZ_ENABLE_WAYLAND", "1")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")
-- hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
-- hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
-- hl.env("SDL_VIDEODRIVER", "wayland")

-- hl.env("GTK_IM_MODULE", "fcitx")
-- hl.env("XMODIFIERS", "@im=fcitx")
-- hl.env("QT_IM_MODULE", "fcitx")

-- hl.env("HYPRCURSOR_THEME", "Nordzy-catppuccin-frappe-dark")
-- hl.env("HYPRCURSOR_SIZE", "32")

-- hl.on("hyprland.start", function()
--     hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland XDG_SESSION_TYPE=wayland")
--     hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE GTK_THEME QT_QPA_PLATFORM QT_WAYLAND_DISABLE_WINDOWDECORATION MOZ_ENABLE_WAYLAND _JAVA_AWT_WM_NONREPARENTING XMODIFIERS QT_IM_MODULE HYPRCURSOR_THEME HYPRCURSOR_SIZE")
-- end)
