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

  # TODO: Integrate extraPackages into helix configuration
  home.packages = with pkgs; [
    # language servers
    gopls
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.fixjson
    nodePackages.markdownlint-cli
    nodePackages.pyright
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.yaml-language-server
    rnix-lsp
    sumneko-lua-language-server
    terraform-ls

    # formatters
    nixpkgs-fmt
    deno
    python310Packages.mdformat
    shellharden
    shfmt
    stylua
  ];
}
