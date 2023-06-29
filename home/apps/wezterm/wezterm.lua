local wezterm = require("wezterm")
local act = wezterm.action
local c = wezterm.config_builder()

c.set_environment_variables = {
  ZVM_TERM = "xterm-256color",
}

c.front_end = "OpenGL"
c.term = "wezterm"
c.font = wezterm.font_with_fallback({
  {
    family = "Iosevka Term",
    weight = "Bold",
  },
  "Symbols Nerd Font",
  "Builtin",
})
c.font_size = 12

c.default_prog = { "fish", "-l" }

c.window_padding = { top = 1, bottom = 1, left = 1, right = 1 }
c.adjust_window_size_when_changing_font_size = false
c.window_decorations = "RESIZE"
c.window_close_confirmation = "NeverPrompt"

c.use_fancy_tab_bar = false
c.tab_bar_at_bottom = true
c.hide_tab_bar_if_only_one_tab = true
c.tab_max_width = 32
c.scrollback_lines = 1000000

c.exit_behavior = "CloseOnCleanExit"
c.clean_exit_codes = { 130 }
c.audible_bell = "Disabled"
c.disable_default_key_bindings = false

local binds = require("binds")
c.keys = binds.keyboard
c.mouse_bindings = binds.mouse

c.ssh_domains = {
  {
    multiplexing = "None",
    name = "catppuccin",
    username = "hammy",
    remote_address = "catppuccin",
    ssh_option = {
      identityfile = "~/.ssh/github",
    },
  },
  {
    multiplexing = "None",
    name = "destiny",
    username = "hammy",
    remote_address = "destiny",
  },
  {
    multiplexing = "None",
    name = "university",
    username = "2563586s",
    remote_address = "ssh1.dcs.gla.ac.uk",
  },
}

wezterm.plugin.require("https://github.com/catppuccin/wezterm").apply_to_config(c, {
  flavor = "mocha",
  sync = wezterm.target_triple:find("darwin") ~= nil,
  sync_flavors = { light = "latte", dark = "mocha" },
})

wezterm.plugin.require("https://github.com/sgoudham/wezterm-bar").apply_to_config(c, {
  indicator = {
    leader = { enabled = false },
  },
  tabs = {
    overrides = {
      ssh = {
        matcher = function(override, title, tab, pane, _)
          return tab.active_pane.foreground_process_name:find(override)
        end,
        title = function(title)
          return "🐎 " .. title
        end,
      },
      nvim = {
        background = "#ffffff",
      },
    },
  },
})

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

c.color_schemes = {
  ["OLEDppuccin"] = custom,
}
c.color_scheme = "OLEDppuccin"

return c
