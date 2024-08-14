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
    catppuccin-whiskers.url = "github:catppuccin/whiskers";
    catppuccin-catwalk.url = "github:catppuccin/catwalk";
  };

  nixConfig = {
    extra-substituters = [
      "https://nekowinston.cachix.org"
      "https://nix-community.cachix.org"
      "https://catppuccin.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nekowinston.cachix.org-1:lucpmaO+JwtoZj16HCO1p1fOv68s/RL1gumpVzRHRDs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
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
    git-view,
    catppuccin-whiskers,
    catppuccin-catwalk,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = final: prev: {
      git-view = git-view.packages.${system}.default;
      whiskers = catppuccin-whiskers.packages.${pkgs.system}.default;
      catwalk = catppuccin-catwalk.packages.${pkgs.system}.default;
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
