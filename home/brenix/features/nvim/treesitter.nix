{ config, pkgs, lib, inputs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      # plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
      plugin = nvim-treesitter;
      type = "lua";
      config = /* lua */ ''
        require("nvim-treesitter.configs").setup {
          ensure_installed = "all",
          auto_install = false,
          parser_install_dir = "/home/brenix/.local/share/nvim/site",
          highlight = {
            enable = true,
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
