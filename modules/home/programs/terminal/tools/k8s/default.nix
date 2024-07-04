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
