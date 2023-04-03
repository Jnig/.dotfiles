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
	"lewis6991/impatient.nvim",
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
	"nvim-lualine/lualine.nvim",
	{ "akinsho/bufferline.nvim", version = "v2.*" },
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},
	"folke/tokyonight.nvim",
	{
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-lua/plenary.nvim",
		},
	},
	"nvim-telescope/telescope-ui-select.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"nvim-treesitter/nvim-treesitter",
	"akinsho/toggleterm.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"RRethy/vim-illuminate",
	"kazhala/close-buffers.nvim",
	"folke/which-key.nvim",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
})
