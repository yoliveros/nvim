return {
  -- "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
  dependencies = {
    {
      "xiyaowong/transparent.nvim",
      opts = {
        extra_groups = {
          "TelescopeNormal",
          "TelescopeBorder"
        }
      }
    }
  },
  opts = {
    flavour = "mocha",
    -- theme = "dragon", -- wave, dragon
    transparent_background = true,
    float = {
      transparent = true
    },
  },
  config = function()
    vim.cmd.colorscheme("catppuccin")
    -- vim.cmd.colorscheme("kanagawa")
  end
}
