vim.g.mapleader = " " -- <leader> is Space; set before lazy.nvim so plugin keymaps use it
vim.g.maplocalleader = "\\" -- <localleader> is \, used by review.nvim's edit-mode keymaps
vim.o.number = true -- the cursor line shows its absolute line number, for jumps like :294
vim.o.relativenumber = true -- other lines show their distance from the cursor, for motions like 12j
vim.o.showmode = false -- lualine already shows the mode, so hide "-- INSERT --"
vim.o.laststatus = 3 -- one status bar across the screen instead of one per window

-- reload files changed outside Neovim (e.g. by Claude Code) when switching panes or buffers,
-- or after the cursor rests for 'updatetime'; not in insert mode, where a conflict prompt would
-- interrupt typing
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("AutoReloadExternalChanges", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" and vim.bo.buftype == "" then
      vim.cmd.checktime()
    end
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({ background = { dark = "mocha", light = "latte" } })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ludovicchabant/vim-gutentags",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- keep tags files in ~/.cache/nvim/tags instead of a "tags" file in each repo
      vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"
      -- index only files ripgrep lists, so .gitignore'd folders like node_modules are skipped
      vim.g.gutentags_file_list_command = "rg --files"
      -- skip Markdown headings ("## Context") and minified files, which flood gd with useless matches
      vim.g.gutentags_ctags_extra_args = { "--languages=-Markdown", "--exclude=*.min.js" }
    end,
    keys = {
      -- gd: jump straight to a single definition, or pick from several with a preview
      {
        "gd",
        function()
          local word = vim.fn.expand("<cword>")
          local exact_pattern = "^" .. vim.fn.escape(word, "\\^$.*~[]") .. "$"
          local tags = vim.fn.taglist(exact_pattern)
          if #tags == 0 then
            vim.notify("No tag definition found for: " .. word, vim.log.levels.WARN)
          elseif #tags == 1 then
            vim.cmd.tag(word)
          else
            Snacks.picker.tags({ search = exact_pattern })
          end
        end,
        desc = "Go to definition (ctags)",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return {
        highlights = require("catppuccin.special.bufferline").get_theme(),
        options = {
          always_show_bufferline = false,
          close_command = function(buffer) Snacks.bufdelete(buffer) end,
          offsets = { { filetype = "snacks_layout_box" } },
        },
      }
    end,
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    },
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    -- Image previews hang Neovim in Ghostty inside tmux, e.g. on gui-admin/public/logosmall.png.
    opts = { picker = {}, explorer = {}, image = { enabled = false } },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Grep word or selection" },
      { "<leader><space>", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last search" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "typescript", "tsx", "javascript", "vue", "html", "css", "scss" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious" },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "georgeguimaraes/review.nvim",
    version = "*",
    dependencies = {
      "esmuellert/codediff.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>rr", "<cmd>Review<cr>", desc = "Review working tree" },
      { "<leader>rc", "<cmd>Review commits<cr>", desc = "Review commits" },
      { "<leader>rb", "<cmd>Review branch<cr>", desc = "Review branch" },
      { "<leader>rn", ":Review note<cr>", mode = { "n", "v" }, desc = "Review: note here" },
      { "<leader>re", "<cmd>Review edit<cr>", desc = "Review: edit comment" },
      { "<leader>rd", "<cmd>Review delete<cr>", desc = "Review: delete comment" },
      { "<leader>rx", "<cmd>Review export<cr>", desc = "Review: export" },
    },
    opts = {},
  },
})
