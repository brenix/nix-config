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

    programs.k9s = {
      enable = true;
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

      skins.skin = with config.lib.stylix.colors.withHashtag; {
        k9s = {
          body = {
            fgColor = base05-hex;
            bgColor = "default";
            logoColor = base0B-hex;
          };

          prompt = {
            fgColor = base05-hex;
            bgColor = base00-hex;
            suggestColor = base0A-hex;
          };

          info = {
            fgColor = base05-hex;
            sectionColor = base0B-hex;
          };

          dialog = {
            fgColor = base05-hex;
            bgColor = "default";
            buttonFgColor = base05-hex;
            buttonBgColor = base00-hex;
            buttonFocusFgColor = base0E-hex;
            buttonFocusBgColor = base0B-hex;
            labelFgColor = base0A-hex;
            fieldFgColor = base05-hex;
          };

          frame = {
            border = {
              fgColor = base00-hex;
              focusColor = base01-hex;
            };

            menu = {
              fgColor = base05-hex;
              keyColor = base0B-hex;
              numKeyColor = base0B-hex;
            };

            crumbs = {
              fgColor = base00-hex;
              bgColor = base00-hex;
              activeColor = base00-hex;
            };

            status = {
              newColor = base0D-hex;
              modifyColor = base0E-hex;
              addColor = base05-hex;
              errorColor = base08-hex;
              highlightcolor = base0A-hex;
              killColor = base0F-hex;
              completedColor = base03-hex;
            };

            title = {
              fgColor = base05-hex;
              bgColor = base00-hex;
              highlightColor = base0A-hex;
              counterColor = base0C-hex;
              filterColor = base0D-hex;
            };
          };

          views = {
            charts = {
              bgColor = "default";
              defaultDialColors = [base0C-hex base0D-hex];
              defaultChartColors = [base0C-hex base0D-hex];
            };

            table = {
              fgColor = base05-hex;
              bgColor = "default";
              cursorFgColor = base00-hex;
              cursorBgColor = base05-hex;
              markColor = base0A-hex;
              header = {
                fgColor = base05-hex;
                bgColor = "default";
                sorterColor = base05-hex;
              };
            };

            xray = {
              fgColor = base05-hex;
              bgColor = "default";
              cursorColor = base01-hex;
              graphicColor = base0C-hex;
              showIcons = false;
            };

            yaml = {
              keyColor = base0D-hex;
              colonColor = base0C-hex;
              valueColor = base05-hex;
            };

            logs = {
              fgColor = base05-hex;
              bgColor = "default";
              indicator = {
                fgColor = base05-hex;
                bgColor = base00-hex;
              };
            };

            help = {
              fgColor = base05-hex;
              bgColor = base00-hex;
              indicator.fgColor = base0D-hex;
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      # (wrapHelm kubernetes-helm {
      #   plugins = with pkgs.kubernetes-helmPlugins; [
      #     helm-diff
      #     helm-git
      #     helm-cm-push
      #   ];
      # })
      cilium-cli
      doppler
      kubernetes-helm
      fluxcd
      # helm-docs
      # helmfile
      # k3d
      krew
      kubecolor
      kubectl
      kubectl-cnpg
      kubectl-example
      kubectl-neat
      kubectl-view-secret
      kubelogin
      kubevirt
      kustomize
      stern
      talosctl
      timoni
    ];
  };
}
