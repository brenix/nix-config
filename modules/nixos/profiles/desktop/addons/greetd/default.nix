{ config
, lib
, ...
}:
with lib; let
  cfg = config.profiles.desktop.addons.greetd;
in
{
  options.profiles.desktop.addons.greetd = {
    enable = mkEnableOption "Enable login greeter";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "Hyprland";
          # TODO: make this configurable using snowfall username
          user = "brenix";
        };
        initial_session = default_session;
      };
    };
  };
}
