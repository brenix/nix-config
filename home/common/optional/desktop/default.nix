{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./gammastep.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    mpv
    mupdf
    # obsidian # NOTE: disabled due to electron 2.5 dependency
    pavucontrol
    piper
    nsxiv
    xdg-utils
  ];

  # home.persistence = {
  #   "/persist/home/brenix" = {
  #     directories = [
  #       ".config/obsidian"
  #     ];
  #     allowOther = true;
  #   };
  # };
}
