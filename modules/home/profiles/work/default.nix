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
    cli.programs = {
      go.enable = true;
      k8s.enable = true;
      python.enable = true;
    };

    programs.gh.enable = true;

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
