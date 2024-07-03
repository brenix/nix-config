{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.desktops.addons.mako;
in {
  options.desktops.addons.mako = {
    enable = mkEnableOption "Enable mako notification daemon";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      catppuccin.enable = true;
      font = "Terminus 12";
      defaultTimeout = 30000;

      backgroundColor = "#${config.colorscheme.palette.base00}";
      textColor = "#${config.colorscheme.palette.base05}";
      borderColor = "#${config.colorscheme.palette.base01}";
      progressColor = "over #${config.colorscheme.palette.base02}";
      extraConfig = ''
        [urgency=high]
        border-color=#${config.colorscheme.palette.base09}
      '';
    };

    home.packages = with pkgs; [
      libnotify
    ];
  };
}
