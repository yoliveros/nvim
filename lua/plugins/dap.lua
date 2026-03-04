return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
  },
  opts = {
  },
  config = function()
    local dap = require("dap")

    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" }
    }
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    }

    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}"
      }
    }
    dap.configurations.cs = {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    }
    dap.configurations.c = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          print("Compiling with make...")
          local system_check = os.execute("make")
          if system_check ~= 0 then
            error("Error: 'make' failed. The debugger wont work")
          end
          local find_cmd = "fd -I -tx -d 2"
          local handle = io.popen(find_cmd)
          if not handle then
            vim.notify("Command can't be executed", vim.log.levels.ERROR)
            return nil
          end
          local binary = handle:read("*a"):gsub("%s+", "")
          handle:close()

          if binary ~= "" and binary ~= nil then
            if not binary:match("^/") and not binary:match("^./") then
              binary = "./" .. binary
            end
            print("Debugging: " .. binary)
            return binary
          else
            return vim.fn.input('Compiled exe: ', vim.fn.getcwd() .. '/', 'file')
          end
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false
      },
      -- {
      -- name = 'Attach to gdbserver :1234',
      -- type = 'cppdbg',
      -- request = 'launch',
      -- MIMode = "gdb",
      -- miDebuggerServerAddress = 'localhost:1234',
      -- minDebuggerPath = "/usr/bin/gdb",
      -- cwd = '${workspaceFolder}',
      -- program = function()
      --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      -- end,
      -- },
    }

    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<F5>", function() dap.continue() end)
    vim.keymap.set("n", "<F10>", function() dap.step_over() end)
    vim.keymap.set("n", "<F11>", function() dap.step_into() end)
    vim.keymap.set("n", "<F12>", function() dap.step_out() end)
    vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
    vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint() end)
    vim.keymap.set("n", "<Leader>lp",
      function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
    vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)
    vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end)
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
      require("dap.ui.widgets").preview()
    end)
    vim.keymap.set("n", "<Leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set("n", "<Leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end)
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end)
    vim.keymap.set("n", "<leader>dq", function()
      dap.terminate()
      dapui.close()
    end)
  end
}
