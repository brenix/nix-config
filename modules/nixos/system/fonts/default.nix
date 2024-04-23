{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs;
        [
          (nerdfonts.override {fonts = ["JetBrainsMono"];})
          google-fonts
          monaco
          noto-fonts-emoji
          terminus_font
        ]
        ++ cfg.fonts;

      fontconfig = {
        antialias = true;
        defaultFonts = {
          serif = ["Inter"];
          sansSerif = ["Inter"];
          monospace = ["Monaco Nerd Font Mono" "JetBrainsMono Nerd Font"];
          emoji = ["Noto Color Emoji"];
        };
        enable = true;
        hinting = {
          autohint = false;
          enable = true;
          style = "slight";
        };
        subpixel = {
          rgba = "rgb";
          lcdfilter = "light";
        };
      };
    };
    # More mac-like font rendering
    # interpreter-version:
    #   35=old freetype, which makes fonts fatter
    #   38=infinality
    #   40=new freetype
    environment.sessionVariables = {
      FREETYPE_PROPERTIES = "truetype:interpreter-version=35 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:no-stem-darkening=0";
    };
  };
}
