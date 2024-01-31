require("valters.remap")
require("valters.set")

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
  { "nvim-telescope/telescope.nvim" },
  'nvim-lua/plenary.nvim',

  --Theme--
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
    vim.cmd([[colorscheme kanagawa]])
    end,
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"tpope/vim-fugitive"},

    --LSP--
    {
	"neovim/nvim-lspconfig",
	dependencies =  {
    		"williamboman/mason.nvim",
    		"williamboman/mason-lspconfig.nvim",
	},
	automatic_installation = true,
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup{
			ensure_installed = { "lua_ls","stylua", "tsserver", "intelephense", }
			}
		require("lspconfig").lua_ls.setup{}
		require("lspconfig").tsserver.setup{}
	end
    },
    {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
    config = function()
    require("nvim-tree").setup {}
  end,
},
})
