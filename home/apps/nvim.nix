{pkgs, ...}: {
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

  programs.fish.shellAbbrs = {
    "lvim" = "NVIM_APPNAME=lazyvim nvim";
  };
}
