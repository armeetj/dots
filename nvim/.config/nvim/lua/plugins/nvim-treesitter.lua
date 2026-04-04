return {
  sources = {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  },
  setup = function()
    local ok_ts, ts = pcall(require, 'nvim-treesitter')
    if ok_ts then
      ts.setup({})

      local installed = ts.get_installed()
      local ensure = {
        'bash',
        'c',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'luap',
        'query',
        'regex',
        'rust',
        'vim',
        'vimdoc',
        'yaml',
      }
      local to_install = {}
      for _, lang in ipairs(ensure) do
        if not vim.list_contains(installed, lang) then
          table.insert(to_install, lang)
        end
      end
      if #to_install > 0 then
        ts.install(to_install)
      end

      vim.keymap.set('n', '<C-space>', function()
        vim.treesitter.incremental_selection.init_selection()
      end, { desc = 'Init treesitter selection', silent = true })
      vim.keymap.set('x', '<C-space>', function()
        vim.treesitter.incremental_selection.node_incremental()
      end, { desc = 'Increment selection', silent = true })
      vim.keymap.set('x', '<BS>', function()
        vim.treesitter.incremental_selection.node_decremental()
      end, { desc = 'Decrement selection', silent = true })
    end

    local ok_textobjects, textobjects = pcall(require, 'nvim-treesitter-textobjects')
    if ok_textobjects then
      textobjects.setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'around a function' },
            ['if'] = { query = '@function.inner', desc = 'inside a function' },
            ['ac'] = { query = '@class.outer', desc = 'around a class' },
            ['ic'] = { query = '@class.inner', desc = 'inside a class' },
            ['ai'] = { query = '@conditional.outer', desc = 'around an if statement' },
            ['ii'] = { query = '@conditional.inner', desc = 'inside an if statement' },
            ['al'] = { query = '@loop.outer', desc = 'around a loop' },
            ['il'] = { query = '@loop.inner', desc = 'inside a loop' },
            ['ap'] = { query = '@parameter.outer', desc = 'around a parameter' },
            ['ip'] = { query = '@parameter.inner', desc = 'inside a parameter' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@parameter.inner'] = 'v',
            ['@function.outer'] = 'v',
            ['@conditional.outer'] = 'V',
            ['@loop.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous function' },
            ['[['] = { query = '@class.outer', desc = 'Previous class' },
            ['[p'] = { query = '@parameter.inner', desc = 'Previous parameter' },
          },
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function' },
            [']]'] = { query = '@class.outer', desc = 'Next class' },
            [']p'] = { query = '@parameter.inner', desc = 'Next parameter' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      })
    end
  end,
}
