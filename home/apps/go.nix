{config, ...}: {
  programs.go.enable = true;
  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
  };
  home.sessionPath = [
    "${config.home.sessionVariables.GOPATH}/bin"
  ];
}
