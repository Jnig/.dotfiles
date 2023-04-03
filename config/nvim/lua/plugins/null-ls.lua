local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local b = null_ls.builtins
local f = b.formatting
local d = b.diagnostics

local sources = {
	-- webdev
	f.prettierd,
	d.eslint_d,
	-- Lua
	f.stylua,
	-- python,
	f.ruff,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
