{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./fonts.nix
    ./gtk.nix
    ./mimeapps.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    authy
    discord
    obsidian
    pavucontrol
    piper
    slack
    xdg-utils
    zoom-us
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/Slack"
        ".config/Unknown Organization" # Zoom
        ".config/discord"
        ".config/obsidian"
        ".config/spotify"
        ".zoom"
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
      ];
      allowOther = true;
    };
  };
}