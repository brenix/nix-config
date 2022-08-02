{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Terminus";
      package = pkgs.terminus_font;
    };
    regular = {
      family = "Noto Sans UI";
      package = pkgs.noto-fonts;
    };
  };
}
