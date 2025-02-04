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
          (google-fonts.override {fonts = ["Poppins" "Cousine"];})
          inter
          nerd-fonts.jetbrains-mono
          nerd-fonts.iosevka
          matrix.monaco
          noto-fonts-emoji
          terminus_font
          matrix.berkeley-mono
        ]
        ++ cfg.fonts;

      fontconfig = {
        antialias = true;
        defaultFonts = {
          serif = ["Inter"];
          sansSerif = ["Inter"];
          monospace = ["Berkeley Mono" "Iosevka NFM" "Cousine" "JetBrainsMono Nerd Font"];
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
          lcdfilter = "default";
        };
      };
    };

    # interpreter-version:
    #   35=old freetype, which makes fonts fatter
    #   38=infinality
    #   40=new freetype
    environment.sessionVariables = {
      FREETYPE_PROPERTIES = "truetype:interpreter-version=35 autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:darkening-parameters=500,450,1000,325,1667,325,2333,0 cff:no-stem-darkening=0";
      # FREETYPE_PROPERTIES = "truetype:interpreter-version=40 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
    };

    # Replace freetype with patched lcdfilter - causes impure evaluation
    # system.replaceRuntimeDependencies = with pkgs; [
    #   {
    #     original = freetype;
    #     replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
    #       patches =
    #         oldAttrs.patches
    #         ++ [
    #           ./lcdfilter.patch
    #         ];
    #     });
    #   }
    # ];
  };
}
