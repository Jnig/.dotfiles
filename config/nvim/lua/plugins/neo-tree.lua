local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neotree.setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
	filesystem = {
		follow_current_file = true,
		use_libuv_file_watcher = true,
	},
	window = {
		width = 40,
	},
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 0,
		},
	},
})
