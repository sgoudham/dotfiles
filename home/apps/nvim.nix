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

    package = pkgs.symlinkJoin {
      name = "neovim";
      paths = [pkgs.neovim-nightly];
      buildInputs = [pkgs.makeWrapper pkgs.gcc];
      postBuild = "wrapProgram $out/bin/nvim --prefix CC : ${pkgs.lib.getExe pkgs.gcc}";
    };

    extraPackages = with pkgs; [
      tree-sitter
    ];
  };

  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
  };

  xdg.configFile = {
    "nvim" = symlink "home/apps/nvim" {recursive = true;};
  };
}
