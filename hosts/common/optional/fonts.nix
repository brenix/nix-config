{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    corefonts
    dejavu_fonts
    hack-font
    material-icons
    noto-fonts
    noto-fonts-emoji
    roboto
    roboto-mono
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
    defaultFonts = {
      serif = [ "Roboto" ];
      sansSerif = [ "Roboto" ];
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Roboto Mono" ];
    };
  };
}
