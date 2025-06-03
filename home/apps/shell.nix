{
  pkgs,
  ...
}:
{
  programs.fish = {
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

      # cursor modes
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      yes | fish_config theme save "Catppuccin Mocha"
    '';

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish;
      }
    ];
  };

  home.shellAliases = {
    magit = "nvim '+Neogit kind=replace'";
    cat = "bat";
    mv = "mv -iv";
  };
}
