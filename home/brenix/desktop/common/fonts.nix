{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      /* family = "M PLUS Code Latin 60"; */
      /* package = pkgs.mplus-outline-fonts.githubRelease; */

      family = "MesloLGS Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Meslo"
          "JetBrainsMono"
        ];
      };
    };
    regular = {
      /* family = "M PLUS 1"; */
      /* package = pkgs.mplus-outline-fonts.githubRelease; */
      family = "Inter";
      package = pkgs.inter;
    };
  };
}
