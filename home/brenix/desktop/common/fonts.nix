{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "RobotoMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; };
    };
    regular = {
      family = "Roboto";
      package = pkgs.roboto;
    };
  };
}
