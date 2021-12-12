-- Auto compile when there are changes to plugins.lua
vim.api.nvim_exec([[
augroup packer-compile
  autocmd BufWritePost plugins.lua PackerCompile
augroup END
]], false)

-- Run packer startup routine
local use = require("packer").use
return require("packer").startup(function()
  -- let packer manage itself
  use {"wbthomason/packer.nvim"}

  -- filetype
  use {"nathom/filetype.nvim"}

  -- lsp-rooter
  use {"ahmedkhalf/lsp-rooter.nvim"}

  -- autopairs
  use {"windwp/nvim-autopairs",
        config=[[require("config.autopairs")]]}

  -- copilot
  -- use {"github/copilot.vim"}

  -- colorizer
  use {"norcalli/nvim-colorizer.lua",
        config=[[require("config.colorizer")]]}

  -- nvim-tree
  use {"kyazdani42/nvim-tree.lua",
        config=[[require("config.nvim-tree")]]}

  -- treesitter
  use {"nvim-treesitter/nvim-treesitter",
        config=[[require("config.nvim-treesitter")]],
        run=":TSUpdate"}

  -- nvim-cmp
  use {"hrsh7th/nvim-cmp",
        config=[[require("config.nvim-cmp")]],
        requires={
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-nvim-lua",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-path"
        }}

  -- nvim-comment
  use {"terrortylor/nvim-comment",
        config=[[require("config.nvim-comment")]]}

  -- rnvimr
  use {"kevinhwang91/rnvimr",
        config=[[require("config.rnvimr")]]}

  -- gitsigns
  use {"lewis6991/gitsigns.nvim",
        config=[[require("config.gitsigns")]],
        requires={"nvim-lua/plenary.nvim"}}

  -- git-blame
  use {"f-person/git-blame.nvim",
        config=[[require("config.git-blame")]]}

  -- telescope
  use {"nvim-telescope/telescope.nvim",
        config=[[require("config.telescope")]],
        requires={
          {"nvim-lua/popup.nvim"},
          {"nvim-lua/plenary.nvim"},
          {"nvim-telescope/telescope-project.nvim"},
        }}

  -- nvim-lspconfig
  use {"neovim/nvim-lspconfig",
        config=[[require("config.nvim-lspconfig")]]}

  -- lspkind
  use {"onsails/lspkind-nvim",
        config=[[require("config.lspkind-nvim")]]}

  -- nvim-lsp-installer
  use {"williamboman/nvim-lsp-installer",
        config=[[require("config.nvim-lsp-installer")]]}

  -- trouble
  use {"folke/trouble.nvim",
        config=[[require("config.trouble")]],
        requires="kyazdani42/nvim-web-devicons"}

  -- nvim-bufferline
  use {"akinsho/nvim-bufferline.lua",
        config=[[require("config.nvim-bufferline")]],
        requires="kyazdani42/nvim-web-devicons"}

  -- nvim-bufdel
  use {"ojroques/nvim-bufdel"}

  -- stabilize
  use {"luukvbaal/stabilize.nvim",
        config=[[require("config.stabilize")]]}

  -- circles
  use {"projekt0n/circles.nvim",
        config=[[require("config.circles")]],
        requires = {{"kyazdani42/nvim-web-devicons"}, {"kyazdani42/nvim-tree.lua", opt = true}}}

  -- lualine
  use {"hoob3rt/lualine.nvim",
        config=[[require("config.lualine")]]}

  -- go.nvim
  use {"ray-x/go.nvim",
        config=[[require("config.go")]]}

  -- better-whitespace
  use {"ntpeters/vim-better-whitespace",
        config=[[require("config.better-whitespace")]]}

  -- better-escape
  use {"max397574/better-escape.nvim",
        config = function()
          require("better_escape").setup()
        end}

  -- todo-comments
  use {"folke/todo-comments.nvim",
        config=[[require("config.todo-comments")]]}

  -- null-ls
  use {"jose-elias-alvarez/null-ls.nvim",
        after="nvim-lspconfig",
        config=[[require("config.null-ls")]]}

  -- indent-blankline
  use {"lukas-reineke/indent-blankline.nvim",
        config=[[require("config.indentline")]]}

  -- navigator
  use {"numToStr/Navigator.nvim",
        config=[[require("config.navigator")]]}

  -- surround
  use {"blackCauldron7/surround.nvim",
        config=[[require("config.surround")]]}

  -- lush
  use {"rktjmp/lush.nvim"}

  -- colorsheme: xresources
  use {"nekonako/xresources-nvim"}

  -- colorscheme: nord (vim)
  use {"shaunsingh/nord.nvim"}

  -- colorscheme: tokyonight
  use {"folke/tokyonight.nvim"}

  -- colorscheme: gruvbox
  use {"ellisonleao/gruvbox.nvim",
        requires={"rktjmp/lush.nvim"}}

  -- colorscheme: github
  -- use {"projekt0n/github-nvim-theme",
  --       config = function()
  --         require("github-theme").setup({
  --           theme_style = "light",
  --           function_style = "italic"
  --         })
  --       end,
  --       after="lualine.nvim"}

  -- switch (vim)
  use {"AndrewRadev/switch.vim"}

  -- terraform (vim)
  use {"hashivim/vim-terraform"}

  -- easyalign (vim)
  use {"junegunn/vim-easy-align"}

  -- quickfix-reflector (vim)
  use {"stefandtw/quickfix-reflector.vim"}

  -- nginx vim
  use {"chr4/nginx.vim"}
end,
  {
    display = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    }
  }
)
