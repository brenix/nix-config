{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.profiles.work;
in {
  options.profiles.work = {
    enable = mkEnableOption "Enable work profile";
  };

  config = mkIf cfg.enable {
    programs = {
      cli = {
        go.enable = true;
        k8s.enable = true;
        python.enable = true;
      };

      gh.enable = true;
    };

    home.packages = with pkgs; [
      argocd
      cilium-cli
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
