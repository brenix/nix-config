{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "UbuntuMono Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Hack"
          "Meslo"
          "JetBrainsMono"
          "UbuntuMono"
        ];
      };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
