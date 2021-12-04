{ pkgs, ... }: {

  xdg.configFile."openbox".source = "./menu.xml";
  xdg.configFile."openbox".source = "./rc.xml";

}
