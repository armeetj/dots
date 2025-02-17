return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    image = {},
    lazygit = {},
  },
  config = function()
    vim.keymap.set('n', '<leader>lg', function()
      require('snacks').lazygit()
    end, { desc = 'Open LazyGit with Snacks' })
  end,
}
