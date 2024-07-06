{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.security;
in {
  options.${namespace}.system.security = {
    enable = mkBoolOpt false "Enable macOS security tweaks";
  };

  config = mkIf cfg.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
