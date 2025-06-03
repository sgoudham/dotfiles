{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    settings = {
      font-size = 18;
      font-family = "Iosevka Term";
      command = "~/.nix-profile/bin/fish --login --interactive";
      window-decoration = "none";
      linux-cgroup = "always";
      maximize = true;
    };
  };

  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
