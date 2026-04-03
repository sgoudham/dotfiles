{
  description = "Home Manager configuration of goudham";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://catppuccin.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
    ];
    # extra-trusted-users = ["@wheel"];
    # warn-dirty = false;
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      nix-index-database,
      nixGL,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        overlays = [
          nixGL.overlays.default
        ];
      };
    in
    {
      homeConfigurations."goudham" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home
          nix-index-database.homeModules.nix-index
          catppuccin.homeModules.catppuccin
        ];

        extraSpecialArgs = {
          inherit inputs;
          flakePath = "/home/goudham/.config/home-manager";
        };
      };
    };
}
