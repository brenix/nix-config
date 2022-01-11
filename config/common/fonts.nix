{ pkgs, ... }: {

  fonts.fonts = with pkgs; [
    corefonts
    cozette
    dejavu_fonts
    dina-font
    gohufont
    hack-font
    liberation_ttf
    material-icons
    noto-fonts
    open-sans
    roboto
    terminus_font
    ubuntu_font_family
    uw-ttyp0
    vistafonts
    weather-icons
    (nerdfonts.override {
      fonts = [ "Gohu" "JetBrainsMono" "RobotoMono" "UbuntuMono" ];
    })
  ];

  # HACK: Causes evaluation to be "impure"
  # Replace freetype with patched lcdfilter
  system.replaceRuntimeDependencies = with pkgs; [{
    original = freetype;
    replacement = pkgs.lib.overrideDerivation freetype (oldAttrs: {
      patches = oldAttrs.patches ++ [
        (fetchurl {
          url =
            "https://gist.githubusercontent.com/brenix/bf63a85755391a52b8c885d0bf77fb10/raw/a9914cb653efce1e6ce2c0b7cb288c97de547cfc/freetype2-cleartype.patch";
          sha256 = "151lwwjjbkndf28l19849md6gzaxrbmjgcxgj8h7mryk0b78zsdv";
        })
      ];
    });
  }];

}
