{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
    };
    regular = {
      family = "Noto Sans UI";
      package = pkgs.noto-fonts;
    };
  };
}
