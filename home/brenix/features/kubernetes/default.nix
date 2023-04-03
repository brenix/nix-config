{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    # grype
    helm-docs
    helmfile
    ko
    krew
    kubectl
    kustomize
    kubernetes-helm
    skopeo
    stern
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/helm"
        ".krew"
        ".kube"
        ".local/share/helm"
      ];
      allowOther = true;
    };
  };
}
