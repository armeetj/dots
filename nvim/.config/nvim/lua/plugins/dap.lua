return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason-nvim-dap setup
    require('mason-nvim-dap').setup {
      ensure_installed = { 'python', 'cppdbg', 'bash', 'go', 'lldb' },
      automatic_installation = true,
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = '/usr/bin/python3', -- Change if needed
            args = { '-m', 'debugpy.adapter' },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    }

    -- UI and virtual text
    dapui.setup()
    require('nvim-dap-virtual-text').setup {
      all_references = true, -- show virtual text on all all references of the variable (not only definitions)
    }

    -- Automatically open/close UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Keybindings (all under <leader>d except <leader>ds which is taken)
    local map = vim.keymap.set
    map('n', '<leader>dc', dap.continue, { desc = '[D]ebug Start/Continue' })
    map('n', '<leader>dn', dap.step_over, { desc = '[D]ebug Step [N]ext/Over' })
    map('n', '<leader>di', dap.step_into, { desc = '[D]ebug Step [I]nto' })
    map('n', '<leader>do', dap.step_out, { desc = '[D]ebug Step [O]ut' })
    map('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug Toggle [B]reakpoint' })
    map('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug Set Conditional [B]reakpoint' })
    map('n', '<leader>dr', dap.repl.open, { desc = '[D]ebug Open REPL' })
    map('n', '<leader>dl', dap.run_last, { desc = '[D]ebug Run Last Session' })
    map('n', '<leader>dt', dapui.toggle, { desc = '[D]ebug [T]oggle UI' })
  end,
}
