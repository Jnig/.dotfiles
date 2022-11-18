vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		show_buffer_icons = true,
		offsets = { { filetype = "neo-tree", text = "neo-tree", padding = 1 } },
	},
})
