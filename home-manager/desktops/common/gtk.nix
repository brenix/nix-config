{ config, pkgs, lib, ... }:
{
  gtk = lib.mkIf (!config.my.settings.headless) {
    enable = true;
    font = {
      name = config.my.settings.fonts.regular;
      size = 10;
    };

    theme = {
      # name = "Nordic-darker";
      # package = pkgs.nordic;
      # name = "Whitesur";
      # package = pkgs.whitesur-gtk-theme;
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };

    gtk4.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  };

  qt = lib.mkIf (!config.my.settings.headless) {
    enable = true;
    platformTheme = "gtk";
    style.name = "Adwaita-dark";
  };

  home.sessionVariables.GTK_THEME = "Adwaita-dark";
  home.pointerCursor = lib.mkIf (!config.my.settings.headless) {
    name = "capitaine-cursors-white";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
