return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "clangd",
        "emmet_language_server",
        "gopls",
        "lua_ls",
        "ts_ls",
        "asm_lsp"
      },
      handlers = {
        function(server_name)
          vim.lsp.config[server_name].setup {
            capabilities = capabilities
          }
        end,
      }
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = nil,
        ["<S-Tab>"] = nil
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }
      }, {
        { name = "buffer" }
      })
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      source = {
        { name = "buffer" }
      }
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      source = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- Lsp config and format on save
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp", { clear = true }),
      callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format { async = false, id = args.data.client_id }
          end
        })
      end
    })

    vim.diagnostic.config({ virtual_text = true })
    vim.g.c_syntax_for_h = 1

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
      }
    })
  end
}
