{config, ...}: {
  programs.go.enable = true;
  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
    GOBIN = "${config.home.sessionVariables.GOPATH}/bin";
  };
  home.sessionPath = [
    "${config.home.sessionVariables.GOBIN}"
  ];
}
