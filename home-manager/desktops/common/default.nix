{ pkgs, ... }:
{
  imports = [
    ./dunst.nix
    ./flameshot.nix
    ./gammastep.nix
    ./gtk.nix
    ./mako.nix
    ./picom.nix
    ./polybar
    ./rofi
    ./waybar.nix
    ./wofi.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    mpv
    mupdf
    nsxiv
    pavucontrol
    playerctl
    xdg-utils
  ];

  services.playerctld = {
    enable = true;
  };
}
