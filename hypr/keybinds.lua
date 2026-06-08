-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- 旧: $mainMod = SUPER
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd "uwsm app -- footclient")
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd "uwsm app -- ghostty +new-window --working-directory ~")

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
-- hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd "uwsm stop")

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd "sleep 0.5; loginctl lock-session")
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd [[loginctl terminate-user ""]])
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd "hyprctl reload")

hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd "walker -m runner")
hl.bind("ALT + Space", hl.dsp.exec_cmd "walker")

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
-- hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })) -- 旧: fullscreen, 0
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- 旧: fullscreen, 1

-- 旧: submap changelayout
hl.bind(mainMod .. " + CTRL + Space", hl.dsp.submap "changelayout")
hl.define_submap("changelayout", function()
  hl.bind("d", hl.dsp.exec_cmd "hyprctl keyword general:layout dwindle")
  hl.bind("m", hl.dsp.exec_cmd "hyprctl keyword general:layout master")
  hl.bind("n", hl.dsp.layout "orientationnext")
  hl.bind("Escape", hl.dsp.submap "reset")
  hl.bind("Return", hl.dsp.submap "reset")
end)

hl.bind(mainMod .. " + m", hl.dsp.layout "addmaster")
hl.bind(mainMod .. " + SHIFT + m", hl.dsp.layout "removemaster")

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- 旧: cyclenext, prev visible / cyclenext, visible
-- NOTE: 新 cycle_next には旧 "visible" フラグに相当するオプションがないため、prev/next のみ移植。
hl.bind(mainMod .. " + code:34", hl.dsp.window.cycle_next({ next = false })) -- key:[
hl.bind(mainMod .. " + code:35", hl.dsp.window.cycle_next()) -- key:]

hl.bind(mainMod .. " + SHIFT + code:34", hl.dsp.layout "orientationprev") -- key:[
hl.bind(mainMod .. " + SHIFT + code:35", hl.dsp.layout "orientationnext") -- key:]
hl.bind(mainMod .. " + CTRL + code:34", hl.dsp.layout "rollprev") -- key:[
hl.bind(mainMod .. " + CTRL + code:35", hl.dsp.layout "rollnext") -- key:]

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- 旧: submap changeratio (splitratio 系は元々コメントアウト)
hl.bind(mainMod .. " + Equal", hl.dsp.submap "changeratio")
hl.define_submap("changeratio", function()
  hl.bind("Equal", hl.dsp.window.resize({ x = 5, y = 0, relative = true }), { repeating = true })
  hl.bind("Minus", hl.dsp.window.resize({ x = -5, y = 0, relative = true }), { repeating = true })
  hl.bind("Escape", hl.dsp.submap "reset")
  hl.bind("Return", hl.dsp.submap "reset")
end)

hl.bind(mainMod .. " + SHIFT + Minus", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind(mainMod .. " + Minus", hl.dsp.workspace.toggle_special "scratchpad")

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:274", hl.dsp.exec_cmd "hyprctl keyword input:scroll_factor 2.0")
hl.bind(mainMod .. " + SHIFT + mouse:274", hl.dsp.exec_cmd "hyprctl keyword input:scroll_factor 1.0")
hl.bind("SHIFT + mouse:275", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SHIFT + mouse:276", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + CTRL + h", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + CTRL + l", hl.dsp.window.move({ direction = "r", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + CTRL + k", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + CTRL + j", hl.dsp.window.move({ direction = "d", group_aware = true }))
hl.bind(mainMod .. " + N", hl.dsp.group.next())
hl.bind(mainMod .. " + B", hl.dsp.group.prev())
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.group.move_window({ forward = true }))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.group.move_window({ forward = false }))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-")

hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd "~/bin/edit_clipboard_wl.sh -t foot -e")
hl.bind("CTRL + ALT + H", hl.dsp.exec_cmd "cliphist list | wofi --dmenu | cliphist decode | wl-copy")
hl.bind("Print", hl.dsp.exec_cmd [[grim -g "$(slurp)" - | swappy -f -]])
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd "~/bin/pipewire_audio_selector.sh")
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd "~/.config/hypr/scripts/no_decoration.sh")

hl.bind("CTRL + SHIFT + 1", hl.dsp.exec_cmd "uwsm app -- /opt/1Password/1password --toggle")
hl.bind("CTRL + " .. mainMod .. " + 1", hl.dsp.exec_cmd "uwsm app -- /opt/1Password/1password --quick-access")
hl.bind("CTRL + SHIFT + L", hl.dsp.exec_cmd "uwsm app -- /opt/1Password/1password --lock")

-- hl.bind(mainMod .. " + Down", hl.dsp.global("overview:overview")) -- hyprexpo
