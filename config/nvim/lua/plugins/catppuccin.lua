require("catppuccin").setup({
  integrations = {
    cmp = true,
    treesitter = true,
    neotree = true,
    telescope = true,
  },
})

vim.cmd.colorscheme("catppuccin")
