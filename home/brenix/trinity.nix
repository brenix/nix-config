{ inputs, pkgs, ... }:
{
  imports = [
    ./global
  ];

  /* colorscheme = inputs.nix-colors.colorSchemes.catppuccin; */
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "catppuccin-mocha" (builtins.readFile (./colorschemes/catppuccin-mocha.yaml));
}
