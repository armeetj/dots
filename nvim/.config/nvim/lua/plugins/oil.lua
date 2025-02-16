return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  --
  config = function()
    require('oil').setup {
      view_options = { show_hidden = true },
      columns = {
        'icon',
        -- "size",
        -- "mtime",
      },

      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
    }
    vim.keymap.set('n', '<leader>e', require('oil').open, { desc = 'Open Oil File Explorer' })
    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open Oil File Explorer' })
  end,
}
