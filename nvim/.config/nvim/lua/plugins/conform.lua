return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      python = { 'ruff_format', 'ruff_organize_imports' },
      tex = { 'latexindent' },
      lua = { 'stylua' },
      go = { 'goimports', 'golines', 'gofmt' },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
    },
  },
  -- keys = {
  --   {
  --     '<leader>F',
  --     function()
  --       require('conform').format { async = true, lsp_format = 'fallback' }
  --     end,
  --     mode = '',
  --     desc = '[F]ormat buffer (sync)',
  --   },
  -- },
}
