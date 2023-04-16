{ inputs, ... }:
{
  imports = [
    ./common/global
  ];

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "catppuccin-mocha" (builtins.readFile (./colorschemes/catppuccin-mocha.yaml));
}
