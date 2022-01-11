{ pkgs, ... }: {

  home.packages = with pkgs; [ openbox obconf ];

  xdg.configFile = {
    "openbox/rc.xml".source = ./rc.xml;
    "openbox/menu.xml".source = ./menu.xml;
    "openbox/autostart".text = ''
      ${pkgs.feh}/bin/feh --no-fehbg --bg-scale $HOME/.background-image
      ${pkgs.systemd}/bin/systemctl --user restart polybar.service
    '';
  };

  home.file.".local/share/themes/Nord" = {
    source = themes/Nord;
    recursive = true;
  };

}
