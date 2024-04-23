{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.desktops.addons.mako;
  inherit (config.colorScheme) palette;
in {
  options.desktops.addons.mako = {
    enable = mkEnableOption "Enable mako notification daemon";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      font = "Terminus 12";
      backgroundColor = "#${palette.base00}";
      textColor = "#${palette.base05}";
      borderColor = "#${palette.base01}";
      progressColor = "over #${palette.base02}";
      extraConfig = ''
        [urgency=high]
        border-color=#${palette.base09}
      '';
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
