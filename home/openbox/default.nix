{ pkgs, ... }: {

  home.packages = with pkgs; [ openbox obconf ];

  xsession = { windowManager = { command = "openbox-session"; }; };

  xdg.configFile = {
    "openbox/rc.xml".source = ./rc.xml;
    "openbox/menu.xml".source = ./menu.xml;
    "openbox/autostart".text = ''
      $HOME/.fehbg
    '';
  };

  home.file.".local/share/themes/Nord" = {
    source = themes/Nord;
    recursive = true;
  };

}
