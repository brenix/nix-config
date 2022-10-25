{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    /* corefonts */
    inter
    font-awesome
    material-icons
    noto-fonts
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
      serif = [ "Inter" ];
      sansSerif = [ "Inter" ];
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Hack Nerd Font Mono" "MesloLGS Nerd Font Mono" "JetBrainsMono Nerd Font" "Roboto Mono" ];
    };
  };
}
