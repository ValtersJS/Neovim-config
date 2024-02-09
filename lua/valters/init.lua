require("valters.remap")
require("valters.set")
-- require("valters.completions")

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
    --AutoComplete--
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
config = function()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("luasnip.loaders.from_vscode").lazy_load()
require("cmp").setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    snippet = {
        expand = function(args)
--        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })
end
    },

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
			ensure_installed = { "lua_ls", "tsserver", "intelephense", "rust_analyzer" }
			}

--        local capabilities = require("cmp_nvim_lsp").default_capabilites()

		require("lspconfig").lua_ls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }
		require("lspconfig").tsserver.setup{}
		require("lspconfig").rust_analyzer.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }
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

-- ,"stylua"
