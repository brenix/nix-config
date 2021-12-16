-- Disable providers we don't need
vim.g.loaded_python_provider  = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- Disable some in built plugins completely
vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1
vim.g.loaded_matchparen       = 1
vim.g.loaded_matchit          = 1
vim.g.loaded_2html_plugin     = 1
vim.g.loaded_getscriptPlugin  = 1
vim.g.loaded_gzip             = 1
vim.g.loaded_logipat          = 1
vim.g.loaded_rrhelper         = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin        = 1
vim.g.loaded_vimballPlugin    = 1
vim.g.loaded_zipPlugin        = 1

-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1

-- Install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Install plugins
require('plugins')

-- Load core configuration
require('keybindings')
require('options')

-- Set colorscheme

-- Nord
vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_italic = true
vim.cmd[[colorscheme nord]]
