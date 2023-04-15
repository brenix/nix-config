{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./gtk.nix
    ./impermanence.nix
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
    spotify
    wootility-lekker
    xdg-utils
    zoom-us
  ];
}
