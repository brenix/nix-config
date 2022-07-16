{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack";
      package = pkgs.hack-font;
    };
    regular = {
      family = "Verdana";
      package = pkgs.corefonts;
    };
  };
}
