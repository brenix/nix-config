{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Monaco Nerd Font";
      package = pkgs.monaco;
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
