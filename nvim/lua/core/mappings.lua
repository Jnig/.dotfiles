local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- navigate tabs
keymap("n", "<tab>", ":bnext<CR>", opts)
keymap("n", "<s-tab>", ":bprevious<CR>", opts)

-- nvim tree
keymap("n", "<leader>f", ":NvimTreeRefresh<CR>", opts) -- refresh
keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", opts) -- search file
keymap("n", "<C-n>", ":Neotree toggle<CR>", opts)

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
