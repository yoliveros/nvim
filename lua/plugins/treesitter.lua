return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context"
  },
  install = {
    "lua",
    "c",
    "go",
    "javascript",
    "typescript",
    "html"
  }
}
