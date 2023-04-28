{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./autocutsel.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    bitwarden
    mpv
    mupdf
    obsidian
    pavucontrol
    piper
    sxiv
    xdg-utils
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/obsidian"
        ".config/Bitwarden"
      ];
      allowOther = true;
    };
  };
}
