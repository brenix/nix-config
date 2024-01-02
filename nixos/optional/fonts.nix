{ pkgs, ... }: {
  fonts = {
    # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" ]; })
      fira
      fira-go
      inter
      joypixels
      monaco
      noto-fonts-emoji
      terminus_font
      ubuntu_font_family
      route159
      uw-ttyp0
      weather-icons
      work-sans
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Route 159" ];
        sansSerif = [ "Route 159" "Inter" "Ubuntu" ];
        monospace = [ "Monaco Nerd Font Mono" "FiraCode Nerd Font Mono" "Ubuntu Nerd Font Mono" ];
        emoji = [ "Joypixels" "Noto Color Emoji" ];
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
  #       # (fetchurl {
  #       #   url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/freetype2/trunk/0003-Enable-infinality-subpixel-hinting.patch";
  #       #   sha256 = "sha256-jmHRLr27y3ZKONR5jucoB0usCqIJeNU4tucEWmOUmrg=";
  #       # })
  #     ];
  #   });
  # }];
}
