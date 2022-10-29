{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
in
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      /*theme = "${colorscheme.slug}";*/
      editor = {
        line-number = "absolute";
        indent-guides.render = true;
        color-modes = true;
      };
      keys.normal = {
        minus = "file_picker";
        space.space = "file_picker";
        space.w = ":w";
        space.v = ":vsplit-new";
        space.minus = ":hsplit-new";
        space.q = ":q";
      };
    };
    themes = import ./theme.nix { inherit colorscheme; };
  };
}
