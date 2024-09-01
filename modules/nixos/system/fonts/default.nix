{
  config,
  pkgs,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.system.fonts;
in {
  options.${namespace}.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs;
        [
          (nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka"];})
          (google-fonts.override {fonts = ["Poppins" "Cousine"];})
          matrix.monaco
          noto-fonts-emoji
          terminus_font
          matrix.berkeley-mono
        ]
        ++ cfg.fonts;

      fontconfig = {
        antialias = true;
        defaultFonts = {
          serif = ["Poppins"];
          sansSerif = ["Poppins"];
          monospace = ["BerkeleyMono Nerd Font Mono" "Iosevka NFM" "Cousine" "JetBrainsMono Nerd Font"];
          emoji = ["Noto Color Emoji"];
        };
        enable = true;
        hinting = {
          autohint = false;
          enable = true;
          style = "none";
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
      # FREETYPE_PROPERTIES = "truetype:interpreter-version=35 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:no-stem-darkening=0";
      FREETYPE_PROPERTIES = "truetype:interpreter-version=40 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0";
    };
  };
}
