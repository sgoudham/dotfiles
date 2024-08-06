{
  config,
  pkgs,
  flakePath,
  ...
}: let
  symlink = fileName: {recursive ? false}: {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
    inherit recursive;
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      tree-sitter
      lazygit
    ];
  };

  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
  };

  xdg.configFile = {
    "nvim" = symlink "home/apps/nvim" {recursive = true;};
  };
}
