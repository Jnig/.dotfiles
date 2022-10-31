require('impatient')


function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require('packer_init')

require('core/autocmd')
require('core/options')
require('core/mappings')
require('lsp')

require('plugins/bufferline')
require('plugins/cmp')
require('plugins/indent-blankline')
require('plugins/null-ls')

require('plugins/nvim-tree')
require('plugins/lualine')
require('plugins/telescope')
require('plugins/toggleterm')
require('plugins/tokyonight')
require('plugins/treesitter')
