return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      }
    }
  }
}
