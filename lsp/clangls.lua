return {
  cmd = {
    "clangd", "--clang-tidy", "--background-index", "--offset-encodeng=utf-8"
  },
  filetypes = { "c", "h", "cpp", "hpp" },
  root_markers = { ".clangd", ".clang-format", "compile_commands.json" }
}
