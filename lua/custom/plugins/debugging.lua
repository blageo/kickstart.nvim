return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    require('dapui').setup()

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

    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<Leader>dc', dap.continue, {})

    -- Configure the LLDB adapter
    dap.adapters.codelldb = {
      type = 'executable',
      command = '/home/blageo/.config/nvim/adapters/codelldb/extension/lldb/bin/lldb', -- Adjust this path if necessary
      name = 'codelldb',
    }

    -- Configure C++ launch configurations
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      },
    }

    -- Use the same configuration for C
    dap.configurations.c = dap.configurations.cpp
  end,
}
