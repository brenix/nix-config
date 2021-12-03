{ config, pkgs, ...}: {

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
      fonts = [
        "Gohu"
        "JetBrainsMono"
        "RobotoMono"
        "UbuntuMono"
      ];
    })
  ];

}
