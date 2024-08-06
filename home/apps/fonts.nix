{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (iosevka-bin.override {variant = "SGr-IosevkaTerm";})
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    victor-mono
    noto-fonts-color-emoji
  ];
}
