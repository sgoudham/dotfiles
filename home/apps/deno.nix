{pkgs, ...}: {
  home.packages = with pkgs; [
    deno
    nodejs_20
    yarn-berry
    corepack_20
  ];
}
