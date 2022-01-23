{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };
  # always installs latest version
  plugin = pluginGit "HEAD";
in
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      #(nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars)) # FIXME: Broken upstream
      Navigator-nvim
      better-escape-nvim
      bufferline-nvim
      circles-nvim
      cmp-buffer
      cmp-emoji
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-treesitter
      cmp_luasnip
      git-blame-nvim
      gitsigns-nvim
      gruvbox-material
      gruvbox-nvim
      indent-blankline-nvim
      lsp-rooter-nvim
      lsp_signature-nvim
      lspkind-nvim
      lualine-lsp-progress
      lualine-nvim
      luasnip
      nginx-vim
      nord-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-bufdel
      nvim-cmp
      nvim-colorizer-lua
      nvim-comment
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      quickfix-reflector-vim
      stabilize-nvim
      switch-vim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-project-nvim
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      vim-better-whitespace
      vim-easy-align
      vim-terraform
      vim-terraform-completion

      # install from HEAD
      (plugin "nvim-treesitter/nvim-treesitter")
    ];

    extraPackages = with pkgs; [
      # plugin deps
      (python3.withPackages (ps: with ps; [ pynvim ueberzug ]))
      tree-sitter

      # language servers
      gopls
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.pyright
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.yaml-language-server
      rnix-lsp
      sumneko-lua-language-server
      terraform-ls

      # formatters
      nixfmt
      nodePackages.prettier
      shellharden
      shfmt
      stylua
    ];

    extraConfig = ''
      lua << EOF
        -- USE LUA FILETYPE DETECTION
        vim.g.do_filetype_lua = 1
        vim.g.did_load_filetypes = 0

        -- DISABLE BUILTINS
        local disabled_built_ins = {
          "2html_plugin",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
        }
        for _, plugin in pairs(disabled_built_ins) do
          vim.g["loaded_" .. plugin] = 1
        end

        -- MODULES
        local modules = {
          "core.utils",
          "core.options",
          "core.mappings",
          "plugins"
        }

        for _, module in ipairs(modules) do
          local ok, err = pcall(require, module)
          if not ok then
            error("Error loading " .. module .. "\n\n" .. err)
          end
        end

        -- COLORSCHEME
        vim.g.nord_contrast = false
        vim.g.nord_borders = true
        vim.g.nord_disable_background = true
        vim.g.nord_italic = true
        vim.cmd[[colorscheme nord]]

      EOF
    '';

  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  xdg.configFile."nvim/colors" = {
    source = ./colors;
    recursive = true;
  };
}
