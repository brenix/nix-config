{
  imports = [
    ./dunst.nix
    ./flameshot.nix
    #./picom.nix
    ./polybar
    ./rofi
    ./unclutter.nix
  ];

  programs.urxvt = {
    enable = true;
    extraConfig = {
      scrollBar = false;
      urlLauncher = "firefox";
    };
  };
}
