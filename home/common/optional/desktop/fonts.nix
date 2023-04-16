{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      # family = "Monaco Nerd Font";
      # package = pkgs.monaco;
      family = "Inconsolata Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Inconsolata"
        ];
      };
    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
