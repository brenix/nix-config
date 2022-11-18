{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Hack"
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
