{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    sccache
    mdbook
  ];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
