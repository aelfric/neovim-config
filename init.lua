vim.wo.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.g.mapleader = " "
vim.g.termguicolors = true
vim.g.hidden = true
vim.g.lazyredraw = true
vim.g.noerrorbells = true
vim.g.scrolloff = "10"
vim.g.spell = true
vim.g.formatoptions = "t1"
vim.g.ignorecase = "smartcase"
vim.g.colorscheme = "selenized"
vim.g.syntax = "on"
vim.g.spellfile = "$HOME/dotfiles/vim/spell/en.utf-8.add"
vim.g.undofile = ".local/share/vim/undo,/tmp"
vim.g.undofile = true
vim.o.incsearch = true
vim.o.completeopt = "menuone,noinsert,noselect"

local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-telescope/telescope.nvim'
  use {'kyazdani42/nvim-web-devicons',
    requires = {
      'kyazdani42/nvim-tree.lua'
    }
  }
  use 'mfussenegger/nvim-jdtls'
  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})
end
)
require("nvim-tree").setup()

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {                                     
  pattern = { "scala", "sbt"},                                       
  callback = function()                                                       
    require("metals").initialize_or_attach({})                                
  end,                                                                        
  group = nvim_metals_group,                                                  
})                                                                            


vim.keymap.set("n","<Leader>ff","<cmd>Telescope find_files<cr>")
vim.keymap.set("n","<leader>fg","<cmd>Telescope live_grep<cr>")
vim.keymap.set("n","<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")


vim.keymap.set("n","<leader>tt", "<cmd>NvimTreeToggle<cr>")

vim.keymap.set("n","<leader>gd","<cmd>lua vim.lsp.buf.definition()<cr>")
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n','ca',vim.lsp.buf.code_action, bufopts)
