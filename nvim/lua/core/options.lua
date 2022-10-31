local options = {
  -- Indenting
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,

  -- Numbers
  number = true,
  numberwidth = 2,
  ruler = false,

  --- other
  signcolumn = "yes", -- otherwise text is shifted on every update
  shortmess = "I", -- ignore intro
  cursorline = true, -- highlight cursor line
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  ignorecase = true, -- ignore case in search patterns
  showmode = false, -- mode is already displayed in tabbar
  undofile = true, -- enable persistent undo
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l" --move to next line on line ending with l
