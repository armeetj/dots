return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      -- General settings for fold behavior
      -- vim.o.foldcolumn = '1' -- '0' is also fine if you prefer no column
      vim.o.foldlevel = 99 -- High value for using the ufo provider
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Key mappings for folding
      vim.keymap.set('n', 'zO', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zC', require('ufo').closeAllFolds, { desc = 'Close all folds' })

      -- ufo plugin setup
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}
