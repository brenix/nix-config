{ pkgs, inputs, system, ... }:
let
  neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
in
rec {
  programs.neovim = {
    enable = true;
    package = neovim-nightly;
    viAlias = true;
  };
}
