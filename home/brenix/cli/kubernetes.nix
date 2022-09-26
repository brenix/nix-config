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
    kustomize
    skopeo
    stern
  ];
}
