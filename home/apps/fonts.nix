{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (iosevka-bin.override {variant = "sgr-iosevka-term";})
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    victor-mono
  ];
}
