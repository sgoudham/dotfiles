{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (wrapHelm kubernetes-helm {plugins = [kubernetes-helmPlugins.helm-diff];})
    kubectl
    kubectx
    kubeseal
    krew
  ];

  home.sessionPath = [
    "${config.home.sessionVariables.KREW_ROOT}/bin"
  ];

  home.sessionVariables = {
    KREW_ROOT = "${config.xdg.dataHome}/krew";
    KUBECACHEDIR = "${config.xdg.cacheHome}/kube";
  };
}
