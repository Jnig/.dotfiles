# Neovim config

## Keymaps

Put a plugin's keymaps in the `keys` field of its lazy.nvim spec in `init.lua`, not in a global
`vim.keymap.set` call. This keeps each mapping next to the plugin it depends on.

```lua
{
  "ludovicchabant/vim-gutentags",
  keys = {
    { "gd", function() ... end, desc = "Go to definition (ctags)" },
  },
},
```

Always give a `desc`. Use `vim.keymap.set` only for mappings that need no plugin.

## Lazy loading

Load a plugin when it is needed, with `event`, `keys` or `cmd`, instead of `lazy = false`. For
plugins that act on opened files, use `event = { "BufReadPost", "BufNewFile" }`. lazy.nvim replays
the triggering event, so the first file is still handled.

Before you defer a plugin, read its `plugin/` script: the event must be one the plugin listens
to (gutentags hooks `BufReadPost` and `BufNewFile`, so it works). Then check that it still
works on the first opened file.

Use `lazy = false` only for plugins that must exist at startup: the colorscheme (with
`priority = 1000`), snacks.nvim and nvim-treesitter.
