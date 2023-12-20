{ pkgs, ... }: {
  fonts = {
    # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "FiraCode" "Hack" "UbuntuMono" ]; })
      fira
      fira-go
      inter
      joypixels
      monaco
      noto-fonts-emoji
      terminus_font
      ubuntu_font_family
      uw-ttyp0
      weather-icons
      work-sans
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        serif = [ "Inter Regular" ];
        sansSerif = [ "Inter Regular" "Fira Sans" "FiraGO" ];
        monospace = [ "Monaco Nerd Font" "FiraCode Nerd Font Mono" "Hack Nerd Font Mono" ];
        emoji = [ "Joypixels" "Noto Color Emoji" ];
      };
      subpixel = {
        rgba = "rgb"; # "rgb", "bgr", "vrgb", "vbgr", "none" (default)
        lcdfilter = "light"; # "none", "default" (default) , "light", "legacy"
      };
    };
  };

  # More mac-like font rendering
  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0 cff:darkening-parameters=500,500,1000,350,1667,350,2333,0";
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
        # (fetchurl {
        #   url = "https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/freetype2/trunk/0003-Enable-infinality-subpixel-hinting.patch";
        #   sha256 = "sha256-jmHRLr27y3ZKONR5jucoB0usCqIJeNU4tucEWmOUmrg=";
        # })
      ];
    });
  }];
}
