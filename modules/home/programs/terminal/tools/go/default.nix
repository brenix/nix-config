{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.go;
in {
  options.${namespace}.programs.terminal.tools.go = {
    enable = mkBoolOpt false "Whether or not install go tools";
  };

  config = mkIf cfg.enable {
    programs.go = {
      enable = true;
      package = pkgs.go_1_22;
      goPath = ".cache/go";
      goBin = ".cache/go/bin";
    };

    home.packages = with pkgs; [
      go-tools
      golangci-lint
      gopls
      goreleaser
      gotools
      reftools
    ];
  };
}
