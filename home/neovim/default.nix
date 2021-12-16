{ pkgs, ... }: {

  home.packages = with pkgs; [
    neovim
    nixfmt
    shfmt
    stylua
    rnix-lsp
  ];

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

}

#{ pkgs, inputs, system, ... }:
#let
#  neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
#in
#rec {
#  programs.neovim = {
#    enable = true;
#    package = neovim-nightly;
#    viAlias = true;
#
#    plugins
#  };
#}
