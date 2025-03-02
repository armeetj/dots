return {
  'bassamsdata/namu.nvim',
  config = function()
    require('namu').setup {
      namu_symbols = {
        enable = true,
        options = {
          initially_hidden = false,
          AllowKinds = {
            default = {
              'Function',
              'Method',
              'Class',
              'Module',
              -- 'Property',
              -- 'Variable',
              -- "Constant",
              -- "Enum",
              -- "Interface",
              -- "Field",
              -- "Struct",
            },
            go = {
              'Function',
              'Method',
              'Struct', -- For struct definitions
              'Field', -- For struct fields
              'Interface',
              'Constant',
              -- "Variable",
              'Property',
              -- "TypeParameter", -- For type parameters if using generics
            },
            lua = { 'Function', 'Method', 'Table', 'Module' },
            python = { 'Function', 'Class', 'Method' },
            -- Filetype specific
            yaml = { 'Object', 'Array' },
            json = { 'Module' },
            toml = { 'Object' },
            markdown = { 'String' },
          },
          window = {
            border = 'single',
          },
        },
      },
      ui_select = { enable = false },
      colorscheme = {
        enable = false,
        options = {
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = true, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
    }
    vim.keymap.set('n', '<leader>ls', ':Namu symbols<cr>', {
      desc = '[L]SP symbols',
      silent = true,
    })

    -- highlights
    -- vim.api.nvim_set_hl(0, 'NamuPreview', { bg = 'red', fg = '#ebdbb2', bold = true }) -- Adjust colors as needed
    -- vim.api.nvim_set_hl(0, 'NamuParent', { bg = '#fabd2f', bold = true })
    -- vim.api.nvim_set_hl(0, 'NamuNested', { bg = '#83a598' })
    -- vim.api.nvim_set_hl(0, 'NamuStyle', { bg = '#d3869b', italic = true })
    -- --
    -- vim.api.nvim_set_hl(0, 'NamuPrefixSymbol', { fg = '#d65d0e' })
    -- vim.api.nvim_set_hl(0, 'NamuSymbolFunction', { fg = '#8ec07c' })
  end,
}
