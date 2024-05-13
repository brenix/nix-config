{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.matrix.apps.mtr;
in {
  options.matrix.apps.mtr = with types; {
    enable = mkBoolOpt false "Whether or not to enable mtr.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mtr
    ];
  };
}
