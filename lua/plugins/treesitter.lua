return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context"
  },
  opts = {
    ensure_installed = {
      "lua",
      "c",
      "go",
      "bash",
      "javascript",
      "typescript",
      "html"
    },
    sync_install = false,
    auto_install = true,
    indent = {
      enable = true
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    }
  }
}
