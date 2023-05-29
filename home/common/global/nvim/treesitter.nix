{ config, pkgs, lib, inputs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      # plugin = nvim-treesitter;
      type = "lua";
      config = /* lua */ ''
        require("nvim-treesitter.configs").setup {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
            disable = { "yaml" },
          },
        }
      '';
    }
  ];
}
