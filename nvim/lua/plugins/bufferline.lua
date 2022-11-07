vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    show_buffer_icons = true,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  }
}
