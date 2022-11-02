{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    gruvbox-material
    gruvbox-nvim
    nord-nvim
    nvim-bufdel
    vim-better-whitespace
    vim-illuminate

    telescope-fzf-native-nvim
    telescope-project-nvim
    {
      plugin = telescope-nvim;
      type = "lua";
      config = /* lua */ ''
        require("telescope").setup({
          defaults = {
            prompt_prefix = "▶ ",
            selection_caret = "▶ ",
          },
          extensions = {
            project = {
              base_dirs = {
                { path = "~/work", max_depth = 3 },
              },
            },
          },
        })

        require("telescope").load_extension("project")
      '';
    }
    {
      plugin = trouble-nvim;
      type = "lua";
      config = /* lua */ ''
        require("trouble").setup()
      '';
    }
    {
      plugin = nvim-femaco;
      type = "lua";
      config = /* lua */ ''
        local femaco = require('femaco')

        femaco.setup{
          prepare_buffer = function(opts)
              vim.cmd('split')
              local win = vim.api.nvim_get_current_win()
              local buf = vim.api.nvim_create_buf(false, false)
              return vim.api.nvim_win_set_buf(win, buf)
          end,
        }
      '';
    }
    {
      plugin = git-blame-nvim;
      type = "lua";
      config = /* lua */ ''
        -- Disable git blame by default
        vim.g.gitblame_enabled = 0
      '';
    }
    {
      plugin = Navigator-nvim;
      type = "lua";
      config = /* lua */ ''
        require("Navigator").setup({
          auto_save = "current",
          disable_on_zoom = true,
        })
      '';
    }
    {
      plugin = bufferline-nvim;
      type = "lua";
      config = /* lua */ ''
        require("bufferline").setup({
          options = {
            offsets = { { filetype = "NvimTree", text = "Explorer" } },
            always_show_bufferline = true,
            buffer_close_icon = "",
            modified_icon = "",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 18,
            max_prefix_length = 15,
            tab_size = 25,
            diagnostics = "nvim_diagnostic",
            enforce_regular_tabs = true,
            view = "multiwindow",
            show_buffer_close_icons = true,
            separator_style = "thin",
          },
          highlights = {
            -- Disable italic fonts
            buffer_selected = {
              italic = false,
            },
          },
        })
      '';
    }
    {
      plugin = range-highlight-nvim;
      type = "lua";
      config = /* lua */ ''
        require('range-highlight').setup{}
      '';
    }
    {
      plugin = nvim-tree-lua;
      type = "lua";
      config = /* lua */ ''
        require("nvim-tree").setup({
          auto_reload_on_write = true,
          open_on_tab = false,
          open_on_setup = false,
          update_cwd = false,
          respect_buf_cwd = true,
          reload_on_bufenter = true,
          renderer = {
            root_folder_modifier = ":~",
            highlight_git = true,
            special_files = { "" },
          },
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          actions = {
            open_file = {
              quit_on_open = true,
              resize_window = true,
            },
          },
          filters = {
            dotfiles = false,
            custom = { ".git", "node_modules", ".cache" },
          },
          view = {
            adaptive_size = true,
            preserve_window_proportions = true,
            width = 40,
          },
        })
      '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = /* lua */ ''
        require('nvim-web-devicons').setup{}
      '';
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = /* lua */ ''
        require("gitsigns").setup({
          signs = {
            add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = {
              hl = "GitSignsChange",
              text = "▎",
              numhl = "GitSignsChangeNr",
              linehl = "GitSignsChangeLn",
            },
          },
          numhl = false,
          linehl = false,
          keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
          },
          watch_gitdir = {
            interval = 1000,
          },
          sign_priority = 6,
          update_debounce = 200,
          status_formatter = nil, -- Use default
        })
      '';
    }
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = /* lua */ ''
        require('colorizer').setup{}
      '';
    }

    lualine-lsp-progress
    {
      plugin = lualine-nvim;
      type = "lua";
      config = /* lua */ ''
        require("lualine").setup({
          options = {
            theme = "auto",
            section_separators = "",
            component_separators = "",
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
              { "diagnostics", sources = { "nvim_diagnostic" } },
              { "filename" },
              { "lsp_progress" },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          extensions = { "nvim-tree", "quickfix" },
        })
      '';
    }
  ];
}
