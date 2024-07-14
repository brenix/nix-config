{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.k8s;
in {
  options.${namespace}.programs.terminal.tools.k8s = {
    enable = mkBoolOpt false "Whether or not to manage kubernetes";
  };

  config = mkIf cfg.enable {
    home.file.".kube/.keep" = {
      text = ''
      '';
    };

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
            };
            logger = {
              buffer = 200000;
              sinceSeconds = -1;
              tail = 500;
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
          helm-git
          helm-cm-push
        ];
      })
      # docker-machine-kvm2
      # fluxcd
      helm-docs
      helmfile
      # k3d
      krew
      kubecolor
      kubectl
      kubectl-cnpg
      kubectl-example
      kubectl-neat
      kubectl-view-secret
      kubelogin
      kubelogin-oidc
      kubevirt
      kustomize
      # minikube
      stern
      # talosctl
      # trivy
    ];
  };
}
