{
  config,
  lib,
  namespace,
  ...
}:
with config.stylix.fonts;
with config.lib.stylix.colors; let
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
          background = "${base00}ff";
          border-color = "${base01}ff";
          title-color = "${base05}ff";
          summary-color = "${base05}ff";
          body-color = "${base05}ff";

          title-font = "${sansSerif.name}:size=${builtins.toString sizes.popups}";
          summary-font = "${sansSerif.name}:size=${builtins.toString sizes.popups}";
          body-font = "${sansSerif.name}:size=${builtins.toString sizes.popups}";

          padding-vertical = 5;
          padding-horizontal = 5;

          max-timeout = 60;
          default-timeout = 10;
          idle-timeout = 60;

          summary-format = "%s";
        };
      };
    };
  };
}
