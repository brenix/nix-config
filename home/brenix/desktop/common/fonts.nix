{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Fragment Mono";
      package = pkgs.fragment-mono;

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
