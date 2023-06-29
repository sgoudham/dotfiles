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
      push.autoSetupRemote = true;
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
      init.defaultBranch = "main";
    };
  };
}
