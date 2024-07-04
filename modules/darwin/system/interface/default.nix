{
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  cfg = config.${namespace}.system.interface;
in {
  options.${namespace}.system.interface = with types; {
    enable = mkEnableOption "macOS interface";
  };

  config = mkIf cfg.enable {
    system.defaults = {
      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleShowScrollBars = "Always";
      };
    };
  };
}
