{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    corefonts
    hack-font
    material-icons
    noto-fonts
    roboto
    terminus_font
    uw-ttyp0
    weather-icons
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" "RobotoMono" "UbuntuMono" ];
    })
  ];


  # More mac-like font rendering
  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=35 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0";
  };

  fonts.fontconfig = {
    hinting.style = "hintfull";
  };
}
