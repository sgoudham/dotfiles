{
  config,
  flakePath,
  ...
}: {
  # Sleep well my prince, one day you will be enabled
  # programs.wezterm = {
  #   enable = true;
  #   package = pkgs.nur.repos.nekowinston.wezterm-nightly;
  # };
  # xdg.configFile."wezterm/wezterm.lua".enable = false;

  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/wezterm";
    recursive = true;
  };
  home.file.".terminfo/w/wezterm".source = wezterm/wezterm_terminfo;
}
