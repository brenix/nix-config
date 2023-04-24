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
    obsidian
    pavucontrol
    piper
    xdg-utils
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/obsidian"
      ];
      allowOther = true;
    };
  };
}
