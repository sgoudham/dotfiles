{ pkgs, ... }: {
  home.packages = with pkgs; [ rustup sccache ];
  home.sessionVariables = { RUSTC_WRAPPER = "sccache"; };
  home.sessionPath = [ "$HOME/.cargo/bin" ];
}
