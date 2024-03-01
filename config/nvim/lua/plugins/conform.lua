return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      vue = { "prettierd" },
      yaml = { "prettierd" },
      json = { "prettierd" },
      markdown = { "prettierd" },
      html = { "prettierd" },
    },
    log_level = vim.log.levels.DEBUG,
  },
}
