{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.${namespace}.roles.desktop.addons.greetd;
in {
  options.${namespace}.roles.desktop.addons.greetd = {
    enable = mkEnableOption "Enable login greeter";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "Hyprland &>/dev/null";
          user = config.${namespace}.user.name;
        };
        initial_session = default_session;
      };
    };
  };
}
