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
            liveViewAutoRefresh = true;
            refreshRate = 2;
            maxConnRetry = 3;
            skipLatestRevCheck = true;
            ui = {
              headless = true;
              logoless = true;
              enableMouse = true;
              noIcons = true;
              # skin = "transparent";
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
      k3d
      krew
      kubectl-neat
      kubectl-view-secret
      kubectl-example
      kubectl-cnpg
      kubecolor
      kubectl
      kubelogin
      kubevirt
      kubelogin-oidc
      # minikube
      # docker-machine-kvm2
      stern
      kustomize
      talosctl
      # trivy
    ];
  };
}
