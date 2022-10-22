{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "MesloLGS Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Meslo"
          "JetBrainsMono"
        ];
      };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
