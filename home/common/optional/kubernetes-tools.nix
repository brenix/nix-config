{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fluxcd
    helm-docs
    helmfile
    krew
    kubebuilder
    kubectl
    kubernetes-helm
    kustomize
    skopeo
    calicoctl
    stern
    trivy
    ytt
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
