{ config, pkgs, lib, inputs, ... }:
let neovim-overlay = inputs.neovim-nightly-overlay.packages.${pkgs.system};
in
{
  imports = [
    ./completion.nix
    ./lsp.nix
    ./misc.nix
    ./treesitter.nix
    ./ui.nix
  ];
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    #package = neovim-overlay.neovim;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraRuntime = {
      "colors/nix-${config.colorscheme.slug}.vim" = {
        text = import ./theme.nix config.colorscheme;
      };
    };

    extraConfig = {
      viml = /* vim */ ''
        "Fix nvim size according to terminal
        "(https://github.com/neovim/neovim/issues/11330)
        augroup fix_size
          autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()
        augroup END

      '';
      lua = /* lua */ ''
        -- Disable built-ins
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

        -- Options
        local indent = 2
        vim.opt.autochdir = true
        vim.opt.autoindent = true
        vim.opt.autoread = true
        vim.opt.backspace = "indent,eol,start"
        vim.opt.backup = false
        vim.opt.conceallevel = 0
        vim.opt.copyindent = true
        vim.opt.expandtab = true
        vim.opt.fillchars = { eob = " " }
        vim.opt.hidden = true
        vim.opt.ignorecase = false
        vim.opt.joinspaces = false
        vim.opt.linebreak = false
        vim.opt.mouse = "a"
        vim.opt.foldenable = false
        vim.opt.number = true
        vim.opt.numberwidth = 2
        vim.opt.shiftround = true
        vim.opt.shiftwidth = indent
        vim.opt.shortmess = "sI"
        vim.opt.signcolumn = "yes"
        vim.opt.smartcase = true
        vim.opt.smartindent = false
        vim.opt.smarttab = true
        vim.opt.softtabstop = indent
        vim.opt.splitbelow = true
        --vim.opt.splitkeep = "screen";
        vim.opt.splitright = true
        vim.opt.swapfile = false
        vim.opt.tabstop = indent
        vim.opt.termguicolors = true
        vim.opt.timeoutlen = 400
        vim.opt.undofile = false
        vim.opt.updatetime = 250
        vim.opt.wildmenu = true
        vim.opt.wrap = false

        -- Mappings
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "
        vim.keymap.set("n", "<Leader>w", ":w<CR>")
        vim.keymap.set("n", "<Leader>W", ":wq<CR>")
        vim.keymap.set("n", "<Leader>q", ":q<CR>")
        vim.keymap.set("n", "<Leader>Q", ":q!<CR>")
        vim.keymap.set("n", "<Leader>e", ':e <C-R>=expand("%:p:h") . "/"<CR>')
        vim.keymap.set("n", "<Leader>x", ":BufDel<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>X", ":BufDel!<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>s", ":split<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>S", ":new<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>V", ":vnew<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>l", ":set invnumber<CR>", { silent = true })
        vim.keymap.set("i", "<S-Tab>", "<C-D>")
        vim.keymap.set("v", "<Tab>", ">gv", { silent = true })
        vim.keymap.set("v", "<S-Tab>", "<gv", { silent = true })
        vim.keymap.set("n", "<Leader>h", ":nohlsearch<cr>", { silent = true })
        vim.keymap.set("n", "<Leader>d", ":FormatToggle<CR>", { silent = true })
        vim.keymap.set("n", "<Tab>", [[<Cmd>BufferLineCycleNext<CR>]], { silent = true })
        vim.keymap.set("n", "<S-Tab>", [[<Cmd>BufferLineCyclePrev<CR>]], { silent = true })
        vim.keymap.set("n", "<Leader>'", ":CommentToggle<CR>", { silent = true })
        vim.keymap.set("v", "<Leader>'", ":CommentToggle<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>g", ":GitBlameToggle<CR>", { silent = true })
        vim.keymap.set("n", "<A-h>", "<CMD>lua require('Navigator').left()<CR>", { silent = true })
        vim.keymap.set("n", "<A-k>", "<CMD>lua require('Navigator').up()<CR>", { silent = true })
        vim.keymap.set("n", "<A-l>", "<CMD>lua require('Navigator').right()<CR>", { silent = true })
        vim.keymap.set("n", "<A-j>", "<CMD>lua require('Navigator').down()<CR>", { silent = true })
        vim.keymap.set("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", { silent = true })
        vim.keymap.set("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", { silent = true })
        vim.keymap.set("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", { silent = true })
        vim.keymap.set("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>n", ":NvimTreeToggle<CR>", { silent = true })
        vim.keymap.set("n", "-", ":NvimTreeFindFile<CR>", { silent = true })
        vim.keymap.set("n", "<Leader><space>", [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { silent = true })
        vim.keymap.set("n", "<C-p>", [[<Cmd>lua require('telescope').extensions.project.project{}<CR>]], { silent = true })
        vim.keymap.set("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { silent = true })
        vim.keymap.set("n", "<Leader>t", ":TodoQuickFix<CR>", { silent = true })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format code" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

        -- Diagnostics
        function add_sign(name, text)
          vim.fn.sign_define(name, { text = text, texthl = name, numhl = name})
        end
        add_sign("DiagnosticSignError", " ")
        add_sign("DiagnosticSignWarn", " ")
        add_sign("DiagnosticSignHint", " ")
        add_sign("DiagnosticSignInfo", " ")

        -- Colorscheme options
        vim.g.nord_contrast = false
        vim.g.nord_borders = true
        vim.g.nord_disable_background = true
        vim.g.nord_italic = true
        vim.g.nord_bold = false
        vim.g.gruvbox_material_background = "hard"
        vim.cmd[[colorscheme catppuccin-mocha]]
        --vim.cmd[[colorscheme nord]]
        --vim.cmd[[colorscheme nix-${config.colorscheme.slug}]]
      '';
    };
  };

  xdg.configFile."nvim/init.lua".onChange = ''
    XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
    for server in $XDG_RUNTIME_DIR/nvim.*; do
      nvim --server $server --remote-send ':source $MYVIMRC<CR>' &
    done
  '';

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "nvim %F";
      icon = "nvim";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = true;
      type = "Application";
      categories = [ "Utility" "TextEditor" ];
    };
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
