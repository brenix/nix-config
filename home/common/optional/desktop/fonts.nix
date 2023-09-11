{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      # family = "Monaco Nerd Font";
      # package = pkgs.monaco;

      family = "MesloLGS Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [ "Meslo" ];
      };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
