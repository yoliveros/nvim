local theme = require('catppuccin')

theme.setup({
  flavour = 'mocha',
  integrations = {
    nvimtree = {
      transparent_panel = true
    },
  }
})

vim.cmd.colorscheme("catppuccin")

-- color background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
