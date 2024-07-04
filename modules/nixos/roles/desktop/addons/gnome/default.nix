{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.roles.desktop.addons.gnome;
in {
  options.${namespace}.roles.desktop.addons.gnome = {
    enable = mkBoolOpt false "Enable or disable the gnome DE.";
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome = {
          enable = true;
          extraGSettingsOverridePackages = [
            pkgs.nautilus-open-any-terminal
          ];
        };
      };
    };

    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    programs.dconf.enable = true;
  };
}
