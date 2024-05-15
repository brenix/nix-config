{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.matrix.system.security;
in {
  options.matrix.system.security = with types; {
    enable = mkEnableOption "macOS security";
  };

  config = mkIf cfg.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
