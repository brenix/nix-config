{ inputs, pkgs, ... }:
{
  imports = [
    ./global
  ];

  /* colorscheme = inputs.nix-colors.colorSchemes.catppuccin; */
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nordppuccin" (builtins.readFile (./colorschemes/nordppuccin.yaml));
}
