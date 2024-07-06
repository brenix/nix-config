{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.interface;
in {
  options.${namespace}.system.interface = {
    enable = mkBoolOpt false "Enable macOS interface tweaks";
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
