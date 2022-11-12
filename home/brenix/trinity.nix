{ inputs, pkgs, ... }:
{
  imports = [
    ./global
  ];

  colorscheme = inputs.nix-colors.colorSchemes.nord;
}
