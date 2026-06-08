-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- 旧: windowrule = match:..., <rule> on/off/value  →  hl.window_rule({ match = {...}, ... })

hl.window_rule({
  match = { class = "^(firefox)$", title = "^(Picture-in-Picture|ピクチャーインピクチャー)$" },
  float = true,
  pin = true,
  no_dim = true,
  opacity = "1.0 override",
  content = "video",
})
hl.window_rule({
  match = { class = "^(firefox)$", title = "^(.*YouTube.*|.*Netflix.*|.*Prime Video.*|.*Twitch.*|Meet.*)$" },
  no_dim = true,
})
hl.window_rule({ match = { class = "^(firefox)$", title = "^(.*Tree Style Tab.*)$" }, float = true })
hl.window_rule({ match = { class = "^(firefox)$", title = "^.*配下のタブを閉じますか.*$" }, float = true })
hl.window_rule({ match = { float = true, class = "^(firefox)$" }, center = true })

hl.window_rule({
  match = { class = "^(google-chrome.*)$", title = "^(.*YouTube.*|.*Netflix.*|.*Prime Video.*|.*Twitch.*|Meet.*)$" },
  no_dim = true,
})

hl.window_rule({ match = { class = "^(zoom)$" }, no_dim = true })

hl.window_rule({ match = { class = "^(.*pavucontrol)$" }, float = true })

hl.window_rule({
  match = { class = "mpv" },
  no_blur = true,
  no_dim = true,
  tile = true,
  rounding = 0,
  content = "video",
})

hl.window_rule({ match = { class = "^(jetbrains-.*)$", title = "^(Go to Line/Column)$" }, float = true })
hl.window_rule({ match = { class = "^(jetbrains-.*)$", title = "^(Rename)$" }, float = true })
hl.window_rule({ match = { class = "^(jetbrains-.*)$", title = "^(Open .*)$" }, float = true })
hl.window_rule({ match = { class = "^(jetbrains-.*)$", title = "^(win.*)$" }, float = true })
hl.window_rule({
  match = { class = "^(jetbrains-.*)$", title = "^(win.*)$", float = true },
  no_initial_focus = true,
  no_blur = true,
  no_anim = true,
  border_size = 0,
  no_dim = true,
})
hl.window_rule({ match = { class = "^(jetbrains-.*)$", title = "^$", float = true }, size = { 640, 480 } })

hl.window_rule({ match = { class = "foot" }, opacity = "0.9 0.9 override" })
hl.window_rule({ match = { class = "footclient" }, opacity = "0.9 0.9 override" })
hl.window_rule({ match = { class = "neovide" }, opacity = "0.9 0.9 override" })
hl.window_rule({ match = { class = ".*ghostty" }, opacity = "0.9 0.9 override" })

hl.window_rule({ match = { class = "^(ueberzugpp.*)$" }, no_dim = true, no_blur = true, no_anim = true })

hl.window_rule({
  match = { class = "^(steam_app_.*)$" },
  no_dim = true,
  no_blur = true,
  no_anim = true,
  decorate = false,
  rounding = 0,
  border_size = 0,
  content = "game",
})

hl.window_rule({
  match = { class = "^(OxygenNotIncluded)$" },
  no_dim = true,
  no_blur = true,
  no_anim = true,
  decorate = false,
  rounding = 0,
  border_size = 0,
  content = "game",
})

hl.window_rule({
  match = { class = "Nsxiv" },
  float = true,
  center = true,
  size = { "monitor_w*0.5", "monitor_h*0.7" },
})

hl.window_rule({
  match = { class = "^(swayimg.*)" },
  float = true,
  center = true,
  size = { "monitor_w*0.7", "monitor_h*0.8" },
  no_dim = true,
  content = "photo",
})

hl.window_rule({ match = { class = "yad" }, float = true })

hl.window_rule({ match = { class = "(.*ripdrag)$" }, float = true })

hl.window_rule({ match = { float = true }, animation = "popin" })

hl.window_rule({
  match = { class = "gamescope" },
  no_blur = true,
  no_dim = true,
  no_anim = true,
  decorate = false,
  rounding = 0,
  border_size = 0,
  content = "game",
  idle_inhibit = "always",
  immediate = true,
})

hl.window_rule({
  match = { xdg_tag = "proton-game" },
  center = true,
  float = true,
  content = "game",
  no_blur = true,
  no_dim = true,
  no_anim = true,
  decorate = false,
  rounding = 0,
  border_size = 0,
  idle_inhibit = "always",
  immediate = true,
})

hl.window_rule({
  match = { class = "pcsx2.*" },
  no_blur = true,
  no_dim = true,
  content = "game",
  idle_inhibit = "focus",
})

hl.window_rule({ match = { class = "pdfpc" }, no_dim = true })
