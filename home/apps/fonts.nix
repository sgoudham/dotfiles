{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (iosevka-bin.override { variant = "SGr-IosevkaTerm"; })
    nerd-fonts.symbols-only
  ];
}
