{ config, pkgs, lib, inputs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      # plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
      plugin = nvim-treesitter;
      type = "lua";
      config = /* lua */ ''
        local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")
        vim.opt.runtimepath:append(parser_install_dir)

        require("nvim-treesitter.configs").setup {
          ensure_installed = "all",
          parser_install_dir = parser_install_dir,
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
