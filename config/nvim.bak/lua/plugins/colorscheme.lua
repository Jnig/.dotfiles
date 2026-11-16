-- Catppuccin, following the terminal's light/dark mode
-- (Neovim detects the terminal background; "auto" picks latte or mocha from it)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "auto",
      background = { light = "latte", dark = "mocha" },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
