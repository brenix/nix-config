{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Monaco Nerd Font";
      package = pkgs.monaco;

      # family = "JetBrainsMono Nerd Font";
      # package = pkgs.nerdfonts.override {
      #   fonts = [ "JetBrainsMono" ];
      # };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
