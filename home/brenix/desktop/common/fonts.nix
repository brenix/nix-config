{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMonoMedium Nerd Font Mono";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
    regular = {
      family = "Noto Sans UI";
      package = pkgs.noto-fonts;
    };
  };
}
