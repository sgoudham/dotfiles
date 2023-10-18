{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    sccache
    mdbook
    cargo-watch
    cargo-msrv
  ];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
