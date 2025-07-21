{
  config,
  pkgs,
  flakePath,
  ...
}:
let
  symlink =
    fileName:
    {
      recursive ? false,
    }:
    {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
      inherit recursive;
    };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    withNodeJs = true;

    package = pkgs.symlinkJoin {
      name = "neovim";
      paths = [ pkgs.neovim-unwrapped ];
      buildInputs = [
        pkgs.makeWrapper
        pkgs.gcc
      ];
      lua = pkgs.neovim-unwrapped.lua;
      postBuild = "wrapProgram $out/bin/nvim --prefix CC : ${pkgs.lib.getExe pkgs.gcc}";
      meta = with pkgs.lib; {
        description = "Neovim, a hyperextensible Vim-based text editor";
        license = licenses.mit;
        platforms = platforms.unix;
        mainProgram = pkgs.neovim-unwrapped;
        teams = [ ];
      };
    };

    extraPackages = with pkgs; [
      tree-sitter
    ];
  };

  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
  };

  xdg.configFile = {
    "nvim" = symlink "home/apps/nvim" { recursive = true; };
  };
}
