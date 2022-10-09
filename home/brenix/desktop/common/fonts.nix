{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "M PLUS Code Latin 60";
      package = pkgs.mplus-outline-fonts.githubRelease;

      /* family = "MesloLGS Nerd Font Mono"; */
      /* package = pkgs.nerdfonts.override { */
      /*   fonts = [ */
      /*     "Meslo" */
      /*     "Hack" */
      /*     "JetBrainsMono" */
      /*     "FantasqueSansMono" */
      /*   ]; */
      /* }; */
    };
    regular = {
      family = "Roboto";
      package = pkgs.roboto;
    };
  };
}
