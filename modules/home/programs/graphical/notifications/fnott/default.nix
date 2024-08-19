{
  config,
  lib,
  namespace,
  ...
}:
with config.stylix.fonts; let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.notifications.fnott;
in {
  options.${namespace}.programs.graphical.notifications.fnott = {
    enable = mkBoolOpt false "Enable fnott notification daemon";
  };

  config = mkIf cfg.enable {
    services.fnott = {
      enable = true;
      settings = {
        main = {
          notification-margin = 2;
        };
      };
    };
  };
}
