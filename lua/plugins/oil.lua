return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  dependencies = {
    -- "nvim-mini/mini.nvim"
    "nvim-tree/nvim-web-devicons"
  },
  lazy = false,
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        ["<C-p>"] = false,
        ["<leader>p"] = "actions.preview",
        ["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      }
    })
    vim.keymap.set("n", "<leader>m", "<CMD>Oil<CR>",
      {
        desc = "Open parent directory"
      })
  end
}
