local wezterm = require("wezterm") 
local act = wezterm.action

return {
  keyboard = {
    -- Fullscreen
    { key = "F11", action = act.ToggleFullScreen },
    -- Zoom
    { key = "z", mods = "ALT|SHIFT", action = act.TogglePaneZoomState },
    -- Copy / Paste
    { key = "c", mods = "ALT|SHIFT", action = act.CopyTo("Clipboard") },
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
      action = act.QuickSelectArgs({
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
  mouse = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor,
    },
  }
}