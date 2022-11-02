{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    cmp-buffer
    cmp-emoji
    cmp-nvim-lsp
    cmp-nvim-lua
    cmp-path
    cmp-treesitter
    lspkind-nvim
    {
      plugin = nvim-cmp;
      type = "lua";
      config = /* lua */ ''
        local cmp = require('cmp')

        cmp.setup{
          formatting = { format = require('lspkind').cmp_format() },
          mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-e>'] = cmp.mapping.close(),
            ['<C-y>'] = cmp.mapping.confirm(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
            ["<S-Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
          sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "treesitter" },
            { name = "path" },
            { name = "emoji" },
            { name = "buffer", option = { get_bufnrs = vim.api.nvim_list_bufs } },
          }
        }
      '';
    }
  ];
}
