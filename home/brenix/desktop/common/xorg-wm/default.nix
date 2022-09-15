{ pkgs, ... }: {

  imports = [
    ./dunst.nix
    ./flameshot.nix
    /* ./picom.nix */
    ./polybar
    ./rofi.nix
  ];

  services.unclutter.enable = true;

}
