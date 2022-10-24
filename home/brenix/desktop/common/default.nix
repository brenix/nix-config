{ lib, pkgs, persistence, ... }:
{
  imports = [
    ./alacritty.nix
    /* ./discord.nix */
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./playerctl.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    authy
    imv
    mupdf
    obsidian
    pavucontrol
    piper
    slack
    spotify
    xdg-utils
    zoom-us
  ];

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [
      ".config/Authy Desktop"
      ".config/obsidian"
      ".config/Slack"
      ".config/spotify"
      ".zoom"
    ];
    "/persist/home/brenix".files = [
      ".config/zoomus.conf"
    ];
  };
}
