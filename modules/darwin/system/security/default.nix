{
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  cfg = config.${namespace}.system.security;
in {
  options.${namespace}.system.security = with types; {
    enable = mkEnableOption "macOS security";
  };

  config = mkIf cfg.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
