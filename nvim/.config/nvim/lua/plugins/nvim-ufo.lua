return {
  sources = {
    'https://github.com/kevinhwang91/nvim-ufo',
    'https://github.com/kevinhwang91/promise-async',
  },
  setup = function()
    local ok, ufo = pcall(require, 'ufo')
    if not ok then
      return
    end

    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.keymap.set('n', 'zO', ufo.openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zC', ufo.closeAllFolds, { desc = 'Close all folds' })

    ufo.setup({
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    })
  end,
}
