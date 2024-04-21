{ pkgs
, config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.programs.k8s;
in
{
  options.cli.programs.k8s = with types; {
    enable = mkBoolOpt false "Whether or not to manage kubernetes";
  };

  config = mkIf cfg.enable {
    programs = {
      k9s = {
        enable = true;
        catppuccin.enable = true;
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
      helmfile
      krew
      kubecolor
      kubectl
      kubelogin
      kubelogin-oidc
      stern
    ];
  };
}
