{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    helmfile
    krew
    kubectl
    kubernetes-helm
    kustomize
    stern
  ];
}
