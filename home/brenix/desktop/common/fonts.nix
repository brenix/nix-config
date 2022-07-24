{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
    regular = {
      family = "Verdana";
      package = pkgs.corefonts;
    };
  };
}
