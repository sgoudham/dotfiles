{
  description = "Home Manager configuration of hammy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/nur";
    nekowinston-nur.url = "github:nekowinston/nur";

    git-view.url = "github:sgoudham/git-view/v1.0.0";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin-toolbox.url = "github:catppuccin/toolbox";
  };

  nixConfig = {
    extra-substituters = [
      "https://nekowinston.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nekowinston.cachix.org-1:lucpmaO+JwtoZj16HCO1p1fOv68s/RL1gumpVzRHRDs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-trusted-users = ["@wheel"];
    warn-dirty = false;
  };

  outputs = {
    nixpkgs,
    nur,
    nekowinston-nur,
    home-manager,
    nix-index-database,
    neovim-nightly-overlay,
    git-view,
    catppuccin-toolbox,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = final: prev: {
      git-view = git-view.packages.${system}.default;
      whiskers = catppuccin-toolbox.packages.${pkgs.system}.whiskers;
      nur = import nur {
        nurpkgs = prev;
        pkgs = prev;
        repoOverrides = {
          nekowinston = nekowinston-nur.packages.${prev.system};
        };
      };
    };
  in {
    homeConfigurations."hammy" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home
        nix-index-database.hmModules.nix-index
        ({config, ...}: {
          config = {
            nixpkgs.overlays = [
              neovim-nightly-overlay.overlay
              overlays
            ];
          };
        })
      ];

      extraSpecialArgs = {
        flakePath =
          if pkgs.stdenv.isDarwin
          then "/Users/hammy/.config/home-manager"
          else "/home/hammy/.config/home-manager";
      };
    };
  };
}
