{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Main Terminal
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    settings = {
      font-size = 18;
      font-family = "Iosevka Term";
      command = "${lib.getExe config.programs.fish.package} --login --interactive";
      window-decoration = "none";
      linux-cgroup = "always";
      maximize = true;
    };
  };

  # Programs to run inside of the terminal
  programs = {
    bat.enable = true;
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };
    # eza = {
    #   enable = false;
    #   enableAliases = false;
    #   icons = true;
    #   extraOptions = [
    #     "--all"
    #     "--long"
    #     "--time-style=long-iso"
    #     "--dereference"
    #     "--octal-permissions"
    #     "--group"
    #   ];
    # };
    # lsd = {
    #   enable = true;
    #   enableAliases = true;
    #   settings = {
    #     no-symlink = false;
    #   };
    # };
    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };
    zoxide = {
      enable = true;
    };
    fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--reverse"
        "--multi"
        "--prompt '▌ '"
      ];
    };
    starship = {
      enable = true;
      settings = lib.importTOML ./starship/config.toml;
    };
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  # Packages that are available inside of a terminal
  home.packages = with pkgs; [
    gh
    ripgrep
    fd
  ];
}
