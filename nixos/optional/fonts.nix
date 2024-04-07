{ pkgs, config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.fonts;
in
{
  options.modules.nixos.fonts = {
    enable = mkEnableOption "Enable fontconfig and font packages";
  };
  config = mkIf cfg.enable {
    fonts = {
      # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        joypixels
        monaco
        terminus_font
        google-fonts
        uw-ttyp0
        weather-icons
        tamzen
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        defaultFonts = {
          serif = [ "Inter" ];
          sansSerif = [ "Inter" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
          emoji = [ "Joypixels" ];
        };
        subpixel = {
          rgba = "rgb"; # "rgb", "bgr", "vrgb", "vbgr", "none" (default)
          lcdfilter = "default"; # "none", "default" (default) , "light", "legacy"
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

    # Replace freetype with patched lcdfilter - causes impure evaluation
    # system.replaceRuntimeDependencies = with pkgs; [{
    #   original = freetype;
    #   replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
    #     patches = oldAttrs.patches ++ [
    #       (fetchurl {
    #         url = "https://aur.archlinux.org/cgit/aur.git/plain/like-ultimate5.patch?h=freetype2-ultimate5";
    #         sha256 = "sha256-lVTTojYZpGz0jlEuW2M2r9CAL0L9r5suR7oMcYFD8d0=";
    #       })
    #     ];
    #   });
    # }];
  };
}
