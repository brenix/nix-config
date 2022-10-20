{ config, pkgs, inputs, ... }:
let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
in
rec {
  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.regular.family;
      size = 10;
    };
    theme = {
      /* name = "Arc"; */
      /* package = pkgs.arc-theme; */

      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;

      /* name = "${config.colorscheme.slug}"; */
      /* package = gtkThemeFromScheme { scheme = config.colorscheme; }; */
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
      size = 16;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };
}
