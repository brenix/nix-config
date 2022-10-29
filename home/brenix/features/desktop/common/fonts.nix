{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Hack Nerd Font Mono";
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
