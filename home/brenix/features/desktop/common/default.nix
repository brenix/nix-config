{ lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./playerctl.nix
    ./qt.nix
    ./xresources.nix
  ];

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    authy
    google-chrome
    obsidian
    pavucontrol
    piper
    slack
    spotify
    wootility-lekker
    xdg-utils
    zoom-us
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/obsidian"
        ".config/google-chrome"
        ".config/Slack"
        ".config/spotify"
        ".config/wootility-lekker"
        ".zoom"
        ".config/Unknown Organization" # Zoom
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
      ];
      allowOther = true;
    };
  };
}
