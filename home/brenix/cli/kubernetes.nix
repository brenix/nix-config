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
    stern
  ];
}
