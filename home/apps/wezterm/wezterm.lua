local wezterm = require("wezterm")
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()
local c = wezterm.config_builder()

-- WSL related
for _, dom in ipairs(wsl_domains) do
  dom.default_cwd = "~"
end

local function get_os()
  local target = wezterm.target_triple
  if string.find(target, "linux") then
    return "linux"
  elseif string.find(target, "darwin") then
    return "macos"
  else
    return "windows"
  end
end

if get_os() == "windows" then
  default_prog = { "wsl.exe", "~", "-d", "Ubuntu-20.04" }
  default_domain = "WSL:Ubuntu-20.04"
end

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

c.default_domain = default_domain
c.wsl_domains = wsl_domains
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

c.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}
c.keys = {
  -- Fullscreen
  { key = "F11", action = wezterm.action.ToggleFullScreen },
  -- Zoom
  { key = "z", mods = "ALT|SHIFT", action = wezterm.action.TogglePaneZoomState },
  -- Copy / Paste
  { key = "c", mods = "ALT|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "ALT|SHIFT", action = act.PasteFrom("Clipboard") },

  -- CMD Palette
  { key = "p", mods = "ALT|SHIFT", action = act.ActivateCommandPalette },

  -- Navigating Tabs
  { key = "h", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "l", mods = "ALT|SHIFT", action = act.ActivateTabRelative(1) },
  -- Close Tabs
  { key = "d", mods = "ALT|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
  -- Swap Panes
  { key = "i", mods = "ALT|SHIFT", action = act.PaneSelect({ alphabet = "asdfghjkl;", mode = "Activate" }) },
  {
    key = "s",
    mods = "ALT|SHIFT",
    action = act.PaneSelect({ alphabet = "asdfghjkl;", mode = "SwapWithActive" }),
  },
  -- Move Tabs Relatively
  { key = "{", mods = "ALT|SHIFT", action = act.MoveTabRelative(-1) },
  { key = "}", mods = "ALT|SHIFT", action = act.MoveTabRelative(1) },

  -- New Tab
  { key = "n", mods = "ALT|SHIFT", action = act({ SpawnTab = "CurrentPaneDomain" }) },
  { key = "m", mods = "ALT|SHIFT", action = act({ SpawnTab = "DefaultDomain" }) },

  -- Open Links Via Keyboard
  {
    key = "o",
    mods = "ALT|SHIFT",
    action = wezterm.action.QuickSelectArgs({
      label = "open url",
      patterns = {
        "https?://\\S+",
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    }),
  },

  -- ScrollBack To Prompt
  { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(-1) },
  { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ScrollToPrompt(1) },
}

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

require("wezterm-bar.plugin").apply_to_config(c, {
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
