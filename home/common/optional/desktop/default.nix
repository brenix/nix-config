{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    authy
    obsidian
    pavucontrol
    piper
    xdg-utils
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/obsidian"
      ];
      allowOther = true;
    };
  };
}
