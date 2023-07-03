{
  description = "Home Manager configuration of hammy";

  inputs = {
    # At the time of writing, nixos-unstable doesn't work for home manager
    # FIXME: https://github.com/NixOS/nixpkgs/issues/236940#issuecomment-1585223723
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/nur";
    nekowinston-nur.url = "github:nekowinston/nur";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    git-view.url = "github:sgoudham/git-view/v1.0.0";
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
    tarball-ttl = 604800;
    warn-dirty = false;
  };

  outputs = {
    nixpkgs,
    nur,
    nekowinston-nur,
    home-manager,
    nix-index-database,
    git-view,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    overlays = final: prev: {
      git-view = git-view.packages.${system}.default;
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
