-- Hyprland Lua config
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
--
-- Hyprland 0.55 以降、設定言語が hyprlang から Lua に変更されました。
-- 旧 hyprland.conf / *.conf 相当の内容を Lua に移植しています。

-- 別ファイルの読み込み (旧: source = ~/.config/hypr/*.conf)
require "monitors"
require "envs"

-------------------
---- AUTOSTART ----
-------------------

-- 旧: exec-once = ...
hl.on("hyprland.start", function()
  hl.exec_cmd "hyprpm reload -n"
  hl.exec_cmd "uwsm app -- wl-paste --watch cliphist -max-items 50 store"
end)

----------------
---- PLUGIN ----
----------------

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- For all categories, see https://wiki.hypr.land/Configuring/Variables/
hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "ctrl:nocaps",
    kb_rules = "",
    repeat_delay = 250,
    repeat_rate = 60,

    follow_mouse = 1,

    float_switch_override_focus = 0,

    touchpad = {
      natural_scroll = false,
    },

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    scroll_factor = 2.0,
  },

  general = {
    gaps_in = 5,
    gaps_out = 20,
    border_size = 3,

    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    layout = "master",

    resize_on_border = true,
    allow_tearing = true,
  },

  decoration = {
    rounding = 10,

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },

    dim_inactive = true,
    dim_strength = 0.4,
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true, -- you probably want this
    default_split_ratio = 0.65,
    force_split = 1,
  },

  master = {
    new_status = "master",
    orientation = "right",
    center_master_fallback = "right",
    mfact = 0.65,
  },

  binds = {
    scroll_event_delay = 50,
  },

  misc = {
    vrr = 0,
    key_press_enables_dpms = true,
    disable_hyprland_logo = true,
    allow_session_lock_restore = true,
    enable_anr_dialog = false,
    anr_missed_pings = 5,
  },

  group = {
    auto_group = true,
    groupbar = {
      font_size = 14,
      height = 18,
      col = {
        active = "rgba(9aad15ee)",
        inactive = "rgba(668888bb)",
      },
    },
  },

  xwayland = {
    force_zero_scaling = true,
  },

  render = {
    direct_scanout = 1,
  },

  cursor = {
    no_break_fs_vrr = 1,
    min_refresh_rate = 48,
  },

  quirks = {
    prefer_hdr = 1,
  },

  debug = {
    disable_logs = true,
    full_cm_proto = false,
  },
})

--------------------
---- ANIMATIONS ----
--------------------

-- 旧: bezier = NAME, x0, y0, x1, y1
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

-- 旧: animation = NAME, ONOFF, SPEED, CURVE, STYLE
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeInOutSine", style = "popin 70%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

---------------------------------
---- KEYBINDS / WINDOW RULES ----
---------------------------------

require "keybinds"
require "windowrules"
