{ lib, inputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  colorscheme = lib.mkDefault colorSchemes.nord;
}
