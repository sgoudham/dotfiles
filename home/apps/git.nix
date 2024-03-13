{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "sgoudham@gmail.com";
    userName = "sgoudham";
    signing = {
      signByDefault = true;
      key = "44E818FD5457EEA4";
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
    };
  };
}
