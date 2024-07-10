{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.work;
in {
  options.${namespace}.roles.work = {
    enable = mkBoolOpt false "Enable work profile";
  };

  config = mkIf cfg.enable {
    matrix = {
      programs = {
        terminal = {
          tools = {
            go.enable = true;
            k8s.enable = true;
          };
        };
      };
    };

    home.packages = with pkgs; [
      argocd
      cfssl
      cilium-cli
      cockroachdb-bin
      # doppler # FIXME: https://github.com/NixOS/nixpkgs/pull/326008
      jira-cli-go
      postgresql
      pre-commit
      shellcheck-minimal
      slides
      sshpass
      vcluster
      yamllint
    ];
  };
}
