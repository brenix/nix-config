{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    corefonts
    hack-font
    inter
    material-icons
    noto-fonts
    noto-fonts-emoji
    roboto
    terminus_font
    uw-ttyp0
    weather-icons
  ];


  # More mac-like font rendering
  environment.sessionVariables = {
    /* FREETYPE_PROPERTIES = "truetype:interpreter-version=35 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0"; */
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0 cff:darkening-parameters=500,500,1000,350,1667,350,2333,0";
  };

  fonts.fontconfig = {
    /* hinting.style = "hintnone"; */
    defaultFonts = {
      serif = [ "Roboto" ];
      sansSerif = [ "Roboto" ];
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Roboto Mono" ];
    };
  };
}
