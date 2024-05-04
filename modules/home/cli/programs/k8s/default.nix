{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.k8s;
in {
  options.cli.programs.k8s = with types; {
    enable = mkBoolOpt false "Whether or not to manage kubernetes";
  };

  config = mkIf cfg.enable {
    programs = {
      k9s = {
        enable = true;
        catppuccin.enable = true;
        settings = {
          k9s = {
            skipLatestRevCheck = true;
            ui = {
              logoless = true;
            };
            logger = {
              buffer = 200000;
            };
          };
        };
      };
    };

    home.file.".kube/.keep" = {
      text = ''
      '';
    };

    # NOTE: Is not OS agnostic
    # systemd.user.tmpfiles.rules = [
    #   "d %h/.kube 0700"
    # ];

    home.packages = with pkgs; [
      fluxcd
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
          helm-git
          helm-cm-push
        ];
      })
      helm-docs
      helmfile
      krew
      kubecolor
      kubectl
      kubelogin
      kubelogin-oidc
      # minikube
      # docker-machine-kvm2
      stern
      # kustomize
      # talosctl
      # trivy
    ];
  };
}
