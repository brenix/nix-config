{ pkgs, ...}: {

  xdg.configFile = {
    "openbox/rc.xml".source = ./rc.xml;
    "openbox/menu.xml".source = ./menu.xml;
  };

  home.file.".local/share/themes/Nord" = {
    source = themes/Nord;
    recursive = true;
  };

}
