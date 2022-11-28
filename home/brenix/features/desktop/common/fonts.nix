{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      # family = "MesloLGS Nerd Font Mono";
      # package = pkgs.nerdfonts.override {
      #   fonts = [
      #     "Hack"
      #     "Meslo"
      #     "JetBrainsMono"
      #   ];
      # };
      family = "Gohufont";
      package = pkgs.gohufont;
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
