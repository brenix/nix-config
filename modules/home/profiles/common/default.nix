{ lib
, pkgs
, config
, inputs
, ...
}:
with lib;
with inputs; let
  cfg = config.profiles.common;
in
{
  imports = [
    catppuccin.homeManagerModules.catppuccin
    nix-colors.homeManagerModule
  ];

  options.profiles.common = {
    enable = mkEnableOption "Enable common configuration";
  };

  config = mkIf cfg.enable {
    colorscheme = nix-colors.colorSchemes.catppuccin-mocha;
    catppuccin.flavour = "mocha";

    browsers.firefox.enable = true;

    system = {
      nix.enable = true;
    };

    cli = {
      shells.fish.enable = true;
    };

    profiles.guis.enable = true;

    security = {
      sops.enable = true;
    };
  };
}
