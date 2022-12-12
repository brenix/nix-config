{ pkgs, ... }: {

  imports = [
    ./dunst.nix
    ./flameshot.nix
    # ./picom.nix
    ./polybar
    ./rofi
  ];

  services.unclutter.enable = true;

}
