local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["c"] = { "<cmd>BDelete this<CR>", "Close Buffer" },
  b = {
    name = "Buffer",
    o = { "<cmd>:BDelete other<CR>", "Close other Buffer"},
    a = { "<cmd>BDelete all<CR>", "Close all Buffer"}
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
