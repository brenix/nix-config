{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.roles.work;
in {
  options.roles.work = {
    enable = mkEnableOption "Enable work profile";
  };

  config = mkIf cfg.enable {
    cli.programs = {
      go.enable = true;
      k8s.enable = true;
    };

    home.packages = with pkgs; [
      argocd
      cilium-cli
      cfssl
      doppler
      kubevirt
      postgresql
      pre-commit
      shellcheck-minimal
      vcluster
      yamllint
    ];
  };
}
