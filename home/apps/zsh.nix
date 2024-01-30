{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = false;
    enableAutosuggestions = true;
    enableCompletion = true;
    # Idk why the highlighting doesn't work properly now
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/922
    # source /nix/store/vzwfgm1a53ihs5x0vwzqd9rbs04vsmgk-zsh-syntax-highlighting-0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    enableSyntaxHighlighting = false;

    envExtra = ''
      export ZVM_INIT_MODE=sourcing
    '';
    initExtra = ''
      # WezTerm
      if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
        TERM=wezterm
        source $HOME/.config/wezterm/wezterm.sh
      fi
    '';

    dotDir = ".config/zsh";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "colorize"
        "docker"
        "docker-compose"
        "git"
        "kubectl"
      ];
    };
    plugins = let
      themepkg = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "zsh-syntax-highlighting";
        rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
        sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
      };
    in [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.nix-zsh-completions;
        file = "share/nix-zsh-completions/nix-zsh-completions.plugin.zsh";
      }
      {
        name = "ctp-zsh-syntax-highlighting";
        src = themepkg;
        file = themepkg + "/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
      }
    ];

    history = {
      path = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}/history";
    };
  };
}
