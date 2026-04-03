{
  inputs,
  pkgs,
  config,
  flakePath,
  ...
}:

{
  imports = [
    ./apps/fonts.nix
    ./apps/shell.nix
    ./apps/git.nix
    ./apps/terminal.nix
    ./apps/nvim.nix
    ./apps/node.nix
    ./apps/rust.nix
  ];

  home.username = "goudham";
  home.homeDirectory = "/home/goudham";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.nix-index-database.comma.enable = true;

  # Make sure that `nixpkgs#...` uses the same registry as the one defined in the flake.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 3d";
  };

  targets.genericLinux.nixGL.packages = inputs.nixGL.packages;
  targets.genericLinux.nixGL.vulkan.enable = false;

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.nvim.enable = false;

  xdg.configFile = {
    "Code/User/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/vscode/settings.json";
    "Code/User/keybindings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/vscode/keybindings.json";
  };
}
