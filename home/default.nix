{
  config,
  pkgs,
  flakePath,
  ...
}: {
  imports = [
    ./apps/wezterm.nix
    # ./apps/zsh.nix
    ./apps/fonts.nix
    ./apps/git.nix
    ./apps/fish.nix
    ./apps/k8s.nix
    ./apps/nap.nix
    ./apps/go.nix
    ./apps/deno.nix
    ./apps/rust.nix
  ];

  programs.home-manager.enable = true;

  nix.package = pkgs.nix;
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  home.username = "hammy";
  home.homeDirectory = "/home/hammy";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    imagemagick
    alejandra
    fd
    vivid
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    TERMINAL = "wezterm-gui";
    LIBVA_DRIVER_NAME = "iHD";
    LS_COLORS = "$(vivid generate catppuccin-mocha)";
    JAVA_HOME = "$SDKMAN_DIR/candidates/java/current";
    GRAALVM_HOME = "$SDKMAN_DIR/candidates/java/22.3.r17-grl";
  };
  home.sessionPath = [
    "${config.xdg.dataHome}/nvim/mason/bin"
    "${config.xdg.dataHome}/JetBrains/Toolbox/scripts"
    "${config.xdg.dataHome}/scripts"
  ];
  home.shellAliases = {
    magit = "nvim '+Neogit kind=replace'";
  };

  xdg.configFile."ideavim/ideavimrc".source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/ideavim/ideavimrc";
  xdg.mime.enable = true;
  # turn off if on nixos (you have bigger problems than that if you get to this point)
  targets.genericLinux.enable = true;
}
