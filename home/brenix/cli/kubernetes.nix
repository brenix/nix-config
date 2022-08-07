{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    helmfile
    krew
    kubesess
    kubectl
    kubernetes-helm
    kustomize
    stern
  ];
}
