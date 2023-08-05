{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    luaLoader.enable = true;

    # -- OPTIONS -- #
    options = {
      autochdir = true;
      autoindent = true;
      autoread = true;
      backspace = "indent,eol,start";
      backup = false;
      conceallevel = 0;
      copyindent = true;
      expandtab = true;
      fillchars = { eob = " "; };
      hidden = true;
      ignorecase = false;
      joinspaces = false;
      linebreak = false;
      mouse = "a";
      foldenable = false;
      number = true;
      numberwidth = 2;
      shiftround = true;
      shiftwidth = 2;
      shortmess = "sI";
      signcolumn = "yes";
      smartcase = true;
      smartindent = false;
      smarttab = true;
      softtabstop = 2;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 400;
      undofile = false;
      updatetime = 250;
      wildmenu = true;
      wrap = false;
    };

    extraFiles = {
      "colors/nix-${config.colorscheme.slug}.vim" = import ./theme.nix config.colorscheme;
    };

    # -- COLORSCHEME -- #
    colorscheme = "nix-${config.colorscheme.slug}";
    # colorschemes = {
    #   nord = {
    #     enable = true;
    #     borders = true;
    #     contrast = false;
    #     disable_background = true;
    #     italic = true;
    #   };
    # };

    # -- KEYBINDINGS -- #
    globals.mapleader = " ";

    maps = {
      normal = {
        "-" = { silent = true; action = ":NvimTreeFindFileToggle<CR>"; };
        "<C-p>" = { silent = true; action = "[[<CMD>lua require('telescope').extensions.project.project{}<CR>]]"; };
        "<S-Tab>" = { silent = true; action = "[[<CMD>BufferLineCyclePrev<CR>]]"; };
        "<Tab>" = { silent = true; action = "[[<CMD>BufferLineCycleNext<CR>]]"; };
        "<leader><space>" = { silent = true; action = "[[<CMD>lua require('telescope.builtin').git_files()<CR>"; };
        "<leader>Q" = { silent = true; action = ":q!<CR>"; };
        "<leader>S" = { silent = true; action = ":new<CR>"; };
        "<leader>V" = { silent = true; action = ":vnew<CR>"; };
        "<leader>W" = { silent = true; action = ":wq<CR>"; };
        "<leader>X" = { silent = true; action = ":BufDel!<CR>"; };
        "<leader>d" = { silent = true; action = ":FormatToggle<CR>"; };
        "<leader>e" = { action = ":e <C-R>=expand(\"%:p:h\") . \"/\"<CR>"; };
        "<leader>h" = { silent = true; action = ":nohlsearch<CR>"; };
        "<leader>l" = { silent = true; action = ":set invnumber<CR>"; };
        "<leader>q" = { silent = true; action = ":q<CR>"; };
        "<leader>s" = { silent = true; action = ":split<CR>"; };
        "<leader>t" = { silent = true; action = ":TodoQuickFix<CR>"; };
        "<leader>v" = { silent = true; action = ":vsplit<CR>"; };
        "<leader>w" = { silent = true; action = ":w<CR>"; };
        "<leader>x" = { silent = true; action = ":BufDel<CR>"; };
      };

      insert = {
        "<S-Tab>" = { action = "<C-D>"; };
      };

      visual = {
        "<Tab>" = { silent = true; action = ">gv"; };
        "<S-Tab>" = { silent = true; action = "<gv"; };
      };
    };

    # -- PLUGINS -- #
    plugins = {

      luasnip = {
        enable = true;
        fromVscode = [
          {
            lazyLoad = true;
          }
          {
            lazyLoad = true;
            paths = [
              ./snippets
            ];
          }
        ];
      };

      nvim-cmp = {
        enable = true;
        performance = {
          debounce = 150;
        };
        preselect = "None";
        snippet.expand = "luasnip";
        mappingPresets = [ "insert" "cmdline" ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
                function(fallback)
                  if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "emoji"; }
          { name = "buffer"; }
        ];
      };
      cmp-buffer.enable = true;
      cmp-emoji.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;

      treesitter = { enable = true; };
      illuminate = { enable = true; };

      lspkind = { enable = true; cmp.enable = true; };
      indent-blankline.enable = true;
      lightline = { enable = true; };
      gitsigns = { enable = true; };
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          project-nvim.enable = true;
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            gr = "references";
            gd = "definition";
          };
        };

        servers = {
          bashls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          terraformls.enable = true;
          yamlls.enable = true;
        };
      };

      lsp-format.enable = true;

      bufferline = {
        enable = true;
      };
      nvim-tree = { enable = true; };
      project-nvim = { enable = true; };
      trouble = { enable = true; };
      todo-comments = { enable = true; };
      nvim-autopairs = { enable = true; };
      comment-nvim = { enable = true; };
      lualine = { enable = true; };
      nvim-colorizer.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins;  [
      comment-box-nvim
      nvim-bufdel
      vim-better-whitespace
      mkdir-nvim
      quickfix-reflector-vim
      switch-vim
      vim-helm
    ];


    # -- MISC -- #
    editorconfig.enable = true;
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [ ".local/share/nvim/project_nvim" ];
      files = [
        ".local/share/nvim/telescope-projects.txt"
        ".local/share/nvim/telescope-workspaces.txt"
        ".local/share/nvim/telescope_history"
      ];
      allowOther = true;
    };
  };

}
