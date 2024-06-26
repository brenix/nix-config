{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.desktops.addons.gtk;
in {
  options.desktops.addons.gtk = {
    enable = mkEnableOption "enable gtk theme management";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      font = {
        name = "Inter";
        size = 12;
      };

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
        # name = "Catppuccin-Mocha-Compact-Blue-Dark";
        # package = pkgs.catppuccin-gtk.override {
        #   accents = ["blue"];
        #   size = "compact";
        #   tweaks = ["rimless"];
        #   variant = "mocha";
        # };
      };

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "blue";
        };
        name = "Papirus-Dark";
      };

      gtk3.extraCss = config.gtk.gtk4.extraCss;

      gtk3.extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-decoration-layout = "appmenu:none";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-error-bell = 0;
        gtk-application-prefer-dark-theme = true;
        gtk-recent-files-max-age = 0;
        gtk-recent-files-limit = 0;
      };

      gtk4.extraConfig = {
        gtk-decoration-layout = "appmenu:none";
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-error-bell = 0;
        gtk-application-prefer-dark-theme = true;
        gtk-recent-files-max-age = 0;
      };
    };

    # home.sessionVariables.GTK_THEME = "Catppuccin-Mocha-Compact-Blue-Dark";
    home.sessionVariables.GTK_THEME = "Adwaita:dark";
    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };
}
