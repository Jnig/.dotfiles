return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = {
      virtual_text = false,
    },
    servers = {
      ["*"] = {
        keys = {
          { "gl", "<cmd>lua vim.diagnostic.open_float()<CR>" },
        },
      },
    },
  },
}
