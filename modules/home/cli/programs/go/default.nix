{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.go;
in {
  options.cli.programs.go = with types; {
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
