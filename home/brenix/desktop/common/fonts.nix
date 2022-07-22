{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Terminus";
      package = pkgs.hack-font;
    };
    regular = {
      family = "Verdana";
      package = pkgs.corefonts;
    };
  };
}
