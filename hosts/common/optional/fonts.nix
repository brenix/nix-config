{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    font-awesome
    inter
    material-icons
    noto-fonts-emoji
    terminus_font
    uw-ttyp0
    weather-icons
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" "RobotoMono" "Meslo" "Hack" ];
    })
  ];

  # More mac-like font rendering
  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0 cff:darkening-parameters=500,500,1000,350,1667,350,2333,0";
  };

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Inter Regular" ];
      sansSerif = [ "Inter Regular" ];
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Monaco Nerd Font" "Hack Nerd Font Mono" "MesloLGS Nerd Font Mono" "JetBrainsMono Nerd Font" "Roboto Mono" ];
    };
  };

  # Replace freetype with patched lcdfilter - causes impure evaluation
  system.replaceRuntimeDependencies = with pkgs; [{
    original = freetype;
    replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
      patches = oldAttrs.patches ++ [
        (fetchurl {
          url = "https://aur.archlinux.org/cgit/aur.git/plain/like-ultimate5.patch?h=freetype2-ultimate5";
          sha256 = "sha256-lVTTojYZpGz0jlEuW2M2r9CAL0L9r5suR7oMcYFD8d0=";
        })
        (fetchurl {
          url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/freetype2/trunk/0003-Enable-infinality-subpixel-hinting.patch";
          sha256 = "sha256-jmHRLr27y3ZKONR5jucoB0usCqIJeNU4tucEWmOUmrg=";
        })
      ];
    });
  }];
}
