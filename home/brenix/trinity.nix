{ inputs, pkgs, ... }:
{
  imports = [
    ./global
  ];

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  # colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile (./colorschemes/nord-dark.yaml));
}
