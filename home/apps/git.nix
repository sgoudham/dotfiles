{ ... }:
{
  home.file.".ssh/allowed_signers".text = ''
    sgoudham@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH2kW8iK+a+msGY4ss5pU04Bye9yHhADNaXfNOVVy82A sgoudham@gmail.com
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "sgoudham@gmail.com";
    userName = "sgoudham";
    signing = {
      format = "ssh";
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };
    difftastic = {
      enable = true;
      background = "dark";
    };
    ignores = [
      # General
      ".DS_Store"
      ".DS_Store?"
      "Thumbs.db"
      "desktop.ini"
      # Temporary Files
      "*.bak"
      "*.swp"
      "*.swo"
      "*~"
      # Editors
      ".idea/"
      ".iml"
      # Nix
      ".direnv/"
      ".envrc"
      # Rust
      "target/"
      # Node
      "node_modules/"
    ];
    extraConfig = {
      branch.sort = "-committerdate";
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
      commit.verbose = true;
      fetch = {
        fsckobjects = true;
        prune = true;
        prunetags = true;
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      push.autoSetupRemote = true;
      receive.fsckObjects = true;
      transfer.fsckobjects = true;
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      url."git@github.com:catppuccin/".insteadOf = "ctp:";
      url."git@github.com:".insteadOf = "gh:";
    };
  };
}
