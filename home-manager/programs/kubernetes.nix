{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    helm-docs
    helmfile
    krew
    kubectl
    kubernetes-helm
    kustomize
    skopeo
    stern
    trivy
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