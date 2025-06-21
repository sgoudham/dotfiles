{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_24
    corepack_24
  ];
}
