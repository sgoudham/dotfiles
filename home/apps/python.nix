{pkgs, ...}: {
  home.packages = with pkgs; [
    python311
    poetry
  ];
}
