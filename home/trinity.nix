{ inputs, ... }:
{
  imports = [
    ./common/global
  ];

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
}
