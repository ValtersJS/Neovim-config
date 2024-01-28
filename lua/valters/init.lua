require("valters.remap")
-- print("hello from valters")

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
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
    vim.cmd([[colorscheme kanagawa]])
    end,
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"tpope/vim-fugitive"},
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
			ensure_installed = { "lua_ls", "tsserver", "intelephense", }
			}
	end
    },
})
