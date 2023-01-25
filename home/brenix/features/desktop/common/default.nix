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

  xsession.initExtra = ''
    ${pkgs.barrier}/bin/barriers -n nix --restart --no-tray --disable-crypto -c /home/brenix/.local/share/barrier/barrier.conf
  '';

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
        ".config/Unknown Organization" # Zoom
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
        ".local/share/barrier/barrier.conf"
      ];
      allowOther = true;
    };
  };
}
