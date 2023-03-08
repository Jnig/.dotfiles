local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"help",
		"query",
		"json",
		"javascript",
		"typescript",
		"python",
		"terraform",
		"css",
		"html",
		"yaml",
		"prisma",
		"go",
		"rust",
		"vue",
		"php",
		"bash",
		"dockerfile",
	},
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
