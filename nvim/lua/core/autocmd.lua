local autocmd = vim.api.nvim_create_autocmd

autocmd("BufLeave", { command = "silent! wa" })

