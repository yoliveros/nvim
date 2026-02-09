return {
  -- "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
  opts = {
    flavour = "mocha",
    float = {
      transparent = true
    }
  },
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end
}
