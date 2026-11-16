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
      terraform = { "terraform_fmt" },
    },
    log_level = vim.log.levels.DEBUG,
  },
}
