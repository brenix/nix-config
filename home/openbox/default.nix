{ pkgs, ... }: {

  home.packages = with pkgs; [ openbox obconf ];

  xdg.configFile = {
    "openbox/rc.xml".source = ./rc.xml;
    "openbox/menu.xml".source = ./menu.xml;
    "openbox/autostart".text = ''
      ${pkgs.xorg.xsetroot}/bin/xsetroot -solid '#2d2f38'
    '';
  };

  home.file.".local/share/themes/Nord" = {
    source = themes/Nord;
    recursive = true;
  };

}
