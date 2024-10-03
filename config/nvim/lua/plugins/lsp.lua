return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = {
      virtual_text = false,
    },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- add a keymap
    keys[#keys + 1] = { "gl", "<cmd>lua vim.diagnostic.open_float()<CR>" }
  end,
}
