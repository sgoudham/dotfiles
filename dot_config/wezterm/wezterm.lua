local wezterm = require("wezterm")
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

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

-- Superscript/Subscript
local function numberStyle(number, script)
  local scripts = {
    superscript = {
      "⁰",
      "¹",
      "²",
      "³",
      "⁴",
      "⁵",
      "⁶",
      "⁷",
      "⁸",
      "⁹",
    },
    subscript = {
      "₀",
      "₁",
      "₂",
      "₃",
      "₄",
      "₅",
      "₆",
      "₇",
      "₈",
      "₉",
    },
  }
  local numbers = scripts[script]
  local number_string = tostring(number)
  local result = ""
  for i = 1, #number_string do
    local char = number_string:sub(i, i)
    local num = tonumber(char)
    if num then
      result = result .. numbers[num + 1]
    else
      result = result .. char
    end
  end
  return result
end

-- Custom Tab Bar
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local RIGHT_DIVIDER = utf8.char(0xe0bc)
  local colours = config.resolved_palette.tab_bar

  local active_tab_index = 0
  for _, t in ipairs(tabs) do
    if t.is_active == true then
      active_tab_index = t.tab_index
    end
  end

  local active_bg = colours.active_tab.bg_color
  local active_fg = colours.active_tab.fg_color
  local inactive_bg = colours.inactive_tab.bg_color
  local inactive_fg = colours.inactive_tab.fg_color
  local new_tab_bg = colours.new_tab.bg_color

  local s_bg, s_fg, e_bg, e_fg

  -- the last tab
  if tab.tab_index == #tabs - 1 then
    if tab.is_active then
      s_bg = active_bg
      s_fg = active_fg
      e_bg = new_tab_bg
      e_fg = active_bg
    else
      s_bg = inactive_bg
      s_fg = inactive_fg
      e_bg = new_tab_bg
      e_fg = inactive_bg
    end
  elseif tab.tab_index == active_tab_index - 1 then
    s_bg = inactive_bg
    s_fg = inactive_fg
    e_bg = active_bg
    e_fg = inactive_bg
  elseif tab.is_active then
    s_bg = active_bg
    s_fg = active_fg
    e_bg = inactive_bg
    e_fg = active_bg
  else
    s_bg = inactive_bg
    s_fg = inactive_fg
    e_bg = inactive_bg
    e_fg = inactive_bg
  end

  local muxpanes = wezterm.mux.get_tab(tab.tab_id):panes()
  local count = #muxpanes == 1 and "" or #muxpanes

  return {
    { Background = { Color = s_bg } },
    { Foreground = { Color = s_fg } },
    {
      Text = " " .. tab.tab_index + 1 .. ": " .. tab.active_pane.title .. numberStyle(count, "superscript") .. " ",
    },
    { Background = { Color = e_bg } },
    { Foreground = { Color = e_fg } },
    { Text = RIGHT_DIVIDER },
  }
end)

return {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font_with_fallback({ "VictorMono Nerd Font" }),
  font_size = 14,
  background = {
    {
      source = { File = "Pictures/astronaut.png" },
      hsb = { brightness = 0.07, hue = 1.0, saturation = 0.1 },
    },
  },

  default_domain = default_domain,
  wsl_domains = wsl_domains,
  default_prog = default_prog,

  window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",

  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 32,
  scrollback_lines = 1000000,

  exit_behavior = "CloseOnCleanExit",
  clean_exit_codes = { 130 },
  audible_bell = "Disabled",
  disable_default_key_bindings = false,

  keys = {
    -- Fullscreen
    { key = "F11", action = wezterm.action.ToggleFullScreen },
    -- Zoom
    { key = "z", mods = "ALT|SHIFT", action = wezterm.action.TogglePaneZoomState },
    -- Copy / Paste
    { key = "C", mods = "CTRL", action = wezterm.action.Copy },
    { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

    -- Open Pane
    -- https://github.com/wez/wezterm/discussions/2426
    -- https://github.com/neovim/neovim/issues/2252
    {
      key = "n",
      mods = "ALT|SHIFT",
      action = wezterm.action_callback(function(window, pane)
        if pane:get_title() == "nvim" then
          window:perform_action(act.SendKey({ key = "n", mods = "ALT|SHIFT" }), pane)
        else
          window:perform_action(act.SplitPane({ direction = "Right", size = { Percent = 50 } }), pane)
        end
      end),
    },
    {
      key = "m",
      mods = "ALT|SHIFT",
      action = wezterm.action_callback(function(window, pane)
        if pane:get_title() == "nvim" then
          window:perform_action(act.SendKey({ key = "m", mods = "ALT|SHIFT" }), pane)
        else
          window:perform_action(act.SplitPane({ direction = "Down", size = { Percent = 50 } }), pane)
        end
      end),
    },

    -- Navigating Panes
    { key = "h", mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "ALT|SHIFT", action = act.ActivatePaneDirection("Down") },
    -- Close Pane
    { key = "c", mods = "ALT|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
    -- Swap Panes
    { key = "i", mods = "ALT|SHIFT", action = act.PaneSelect({ alphabet = "asdfghjkl;", mode = "Activate" }) },
    {
      key = "s",
      mods = "ALT|SHIFT",
      action = act.PaneSelect({ alphabet = "asdfghjkl;", mode = "SwapWithActive" }),
    },
    -- Resize Panes
    { key = "LeftArrow", mods = "ALT|SHIFT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
    { key = "DownArrow", mods = "ALT|SHIFT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
    { key = "UpArrow", mods = "ALT|SHIFT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
    { key = "RightArrow", mods = "ALT|SHIFT", action = act({ AdjustPaneSize = { "Right", 5 } }) },

    -- New Tab
    { key = "n", mods = "CTRL|SHIFT", action = act({ SpawnTab = "CurrentPaneDomain" }) },
    -- Swap Tabs
    { key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

    -- Open Links
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
  },
}
