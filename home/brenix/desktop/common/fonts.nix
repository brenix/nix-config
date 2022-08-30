{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "MesloLGS Nerd Font Mono";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Meslo"
          "Hack"
          "JetBrainsMono"
          "FantasqueSansMono"
        ];
      };
      /* family = "BlexMono Nerd Font"; */
      /* package = pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; }; */
    };
    regular = {
      family = "Roboto";
      package = pkgs.roboto;
    };
  };
}
