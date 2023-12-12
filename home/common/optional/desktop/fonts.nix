{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Monaco Nerd Font";
      package = pkgs.monaco;

      # family = "Monaspace Neon";
      # package = pkgs.monaspace;

      # family = "JetBrainsMono Nerd Font Mono";
      # package = pkgs.nerdfonts.override {
      # fonts = [ "JetBrainsMono" ];
      # };

      # family = "Terminus";
      # package = pkgs.terminus_font;

    };
    regular = {
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
