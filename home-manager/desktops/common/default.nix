{ config, lib, pkgs, ... }:
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
    ./xdg.nix
  ];

  home.packages = with pkgs; lib.mkIf (!config.my.settings.headless) [
    mpv
    mupdf
    nsxiv
    pavucontrol
    playerctl
    xdg-utils
  ];

  services.playerctld = {
    enable = lib.mkIf (!config.my.settings.headless) true;
  };
}
