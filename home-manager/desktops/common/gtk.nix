{ config, pkgs, lib, ... }:
{
  gtk = lib.mkIf (!config.my.settings.headless) {
    enable = true;
    font = {
      name = config.my.settings.fonts.regular;
      size = 11;
    };

    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };

      # name = "Nordic-darker";
      # package = pkgs.nordic;

      # name = "Whitesur";
      # package = pkgs.whitesur-gtk-theme;

      # name = "adw-gtk3-dark";
      # package = pkgs.adw-gtk3;
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
      gtk-decoration-layout = "menu:";
    };

    gtk4.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };
  };

  xdg.configFile = lib.mkIf (!config.my.settings.headless) {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  qt = lib.mkIf (!config.my.settings.headless) {
    enable = true;
    platformTheme = "gtk";
    style.name = "Catppuccin-Mocha-Compact-Blue-Dark";
    style.package = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "mocha";
    };
  };

  home.sessionVariables.GTK_THEME = "Catppuccin-Mocha-Compact-Blue-Dark";
 
  home.pointerCursor = lib.mkIf (!config.my.settings.headless) {
    name = "capitaine-cursors-white";
    package = pkgs.capitaine-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };
}
