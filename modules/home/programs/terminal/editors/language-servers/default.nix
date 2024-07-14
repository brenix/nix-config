{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.language-servers;
in {
  options.${namespace}.programs.terminal.editors.language-servers = {
    enable = mkBoolOpt false "Whether or not to enable language-servers";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # lua-language-server
      # terraform-ls
      alejandra
      bash-language-server
      deno
      golangci-lint-langserver
      gopls
      helm-ls
      marksman
      nil
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      pyright
      shfmt
    ];
  };
}
