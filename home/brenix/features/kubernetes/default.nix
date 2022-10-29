{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    grype
    helm-docs
    helmfile
    krew
    kubectl
    kubernetes-helm
    #kustomize
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
    };
  };
}
