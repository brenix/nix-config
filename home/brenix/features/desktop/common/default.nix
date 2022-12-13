{ lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./playerctl.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    authy
    obsidian
    pavucontrol
    slack
    spotify
    xdg-utils
    zoom-us
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/obsidian"
        ".config/Slack"
        ".config/spotify"
        ".zoom"
      ];
      files = [
        ".config/zoomus.conf"
      ];
      allowOther = true;
    };
  };
}
