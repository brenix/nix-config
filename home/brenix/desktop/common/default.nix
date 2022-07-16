{ lib, pkgs, persistence, ... }:
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

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      documents = "$XDG_RUNTIME_DIR/documents/";
      download = "$XDG_RUNTIME_DIR/downloads";
      videos = "$XDG_RUNTIME_DIR/videos/";
      music = "$XDG_RUNTIME_DIR/music/";
      pictures = "$XDG_RUNTIME_DIR/pictures/";
      desktop = "$XDG_RUNTIME_DIR/desktop/";
      publicShare = "$XDG_RUNTIME_DIR/public/";
      templates = "$XDG_RUNTIME_DIR/templates/";
    };
  };

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    authy
    discord
    imv
    mupdf
    pamixer
    pavucontrol
    piper
    slack
    spotify
    sxiv
    zoom-us
  ];

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [
      ".config/Authy Desktop"
    ];
  };
}
