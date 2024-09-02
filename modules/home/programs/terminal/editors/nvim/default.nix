{
  config,
  lib,
  inputs,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.editors.nvim;
in {
  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
    ]
    ++ lib.snowfall.fs.get-non-default-nix-files ./.;

  options.${namespace}.programs.terminal.editors.nvim = {
    enable = mkBoolOpt false "enable nvim editor";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      viAlias = true;
      vimAlias = true;
      defaultEditor = false;
    };

    programs.nixvim = {
      enable = true;
      extraPlugins = with pkgs.vimPlugins; [plenary-nvim];
      defaultEditor = false;
      viAlias = true;
      vimAlias = true;
    };
  };
}
