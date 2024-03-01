local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000},
	{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
    	end,
		dependencies = { {'nvim-tree/nvim-web-devicons'}}
	},
	{
    "williamboman/mason.nvim"
},
{
	"mhartington/formatter.nvim"
},
--{
--	"folke/lsp-colors.nvim"
--},
{
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
 },
},
{
	"neovim/nvim-lspconfig"
},
{
	"nvim-lua/plenary.nvim"
},
{
	"nvim-telescope/telescope.nvim"
},
{
	"nvim-tree/nvim-tree.lua"
}
}, opts)

require("mason").setup()
require("nvim-tree").setup()

local lspconf = require("lspconfig")
lspconf.rust_analyzer.setup {
}
lspconf.lua_ls.setup{}

vim.cmd [[colorscheme catppuccin-macchiato]]
