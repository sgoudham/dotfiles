{
  lib,
  pkgs,
  ...
}:
{
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
    fish = {
      enable = true;
      shellAbbrs = {
        # Nix
        nb = "nix build";
        nr = "nix run";
        nd = "nix develop";
        nrpkgs = "nix run nixpkgs#";
        nf = "nix flake";
        nfl = "nix flake lock";
        hms = "home-manager switch";

        # Git
        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gca = "git commit --amend";
        gcan = "git commit --amend --no-edit";
        gcm = "git commit -m";
        gco = "git checkout";
        gcot = "git checkout --track";
        gcb = "git checkout -b";
        gd = "git diff";
        gl = "git pull";
        gp = "git push";
        gpfl = "git push --force-with-lease";
        gr = "git rebase";
        gri = "git rebase -i";
        gra = "git rebase --abort";
        grc = "git rebase --continue";
        gs = "git switch";
        gsc = "git switch --create";
        gst = "git status";

        # Rust
        cb = "cargo build";
        cbr = "cargo build --release";
        ct = "cargo test";
        ctlog = "cargo test -- --nocapture";
        cpub = "cargo publish";
        cpubdry = "cargo publish --dry-run";
      };

      interactiveShellInit = ''
        set fish_greeting

        # set vi bindings
        fish_vi_key_bindings

        # set vi cursor
        # wezterm isn't supported out of the box, but we can safely force-enable it.
        # set fish_vi_force_cursor 1
        # fish_vi_cursor

        # cursor modes
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_visual block

        # bind -s --user -M insert \e "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f repaint-mode; end"

        yes | fish_config theme save "Catppuccin Mocha"
      '';

      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish;
        }
      ];
    };
  };
}
