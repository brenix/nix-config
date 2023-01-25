{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Monaco Nerd Font";
      package = pkgs.monaco;
      # family = "JetBrainsMono Nerd Font";
      # package = pkgs.nerdfonts.override {
      #   fonts = [
      #     "Hack"
      #     "Meslo"
      #     "JetBrainsMono"
      #     "UbuntuMono"
      #   ];
      # };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
