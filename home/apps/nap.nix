{pkgs, ...}: {
  home.packages = [pkgs.nap];
  home.sessionVariables = {
    NAP_THEME = "catppuccin_mocha";
    NAP_PRIMARY_COLOR = "#f5c2e7";
    NAP_RED = "#f38ba8";
    NAP_GREEN = "#a6e3a1";
    NAP_FOREGROUND = "#b4befe";
    NAP_BACKGROUND = "#11111b";
    NAP_BLACK = "#11111b";
    NAP_GRAY = "#bac2de";
    NAP_WHITE = "#FFFFFF";
  };
}
