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
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
{
	"hrsh7th/cmp-calc"
},
{
	"hrsh7th/cmp-path"
},
{
	'hrsh7th/cmp-nvim-lsp'
},
{
	'hrsh7th/nvim-cmp',
},
{
	"mhartington/formatter.nvim"
},
{
	"tris203/hawtkeys.nvim",
	dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = {}
},
--{
--   "m4xshen/hardtime.nvim",
--   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
--   opts = {}
--},
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
},
{
	'ThePrimeagen/vim-be-good'
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
},
{
	"mbbill/undotree"
},
{
	"nvim-treesitter/nvim-treesitter"
},
{
	"folke/twilight.nvim"
},
{
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
},
{
	'saadparwaiz1/cmp_luasnip'
},
{
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- optional
	opts = {
		snippetDir = "~/.config/snippets",
	}
},
{
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
        event = "InsertEnter",
        config = function()
        require("copilot").setup({})
  end,
},
{ "Gelio/cmp-natdat", config = true },
}, opts)

require("mason").setup()
require("nvim-tree").setup()

require("scissors").setup{
	snippetDir = "~/.config/snippets"
}

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/snippets" } })
local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
       { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
      { name = "path" },
      { name = "calc" },
      { name = "natdat" }
    })
  })


local lspconf = require("lspconfig")
lspconf.rust_analyzer.setup {}
lspconf.lua_ls.setup{}

vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.cmd [[colorscheme catppuccin-macchiato]]

vim.cmd [[set relativenumber]]
