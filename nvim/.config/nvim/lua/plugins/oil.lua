return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = false,
    view_options = {
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  --
  config = function()
    require('oil').setup {
      columns = {
        'icon',
        -- "size",
        -- "mtime",
      },

      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
    }
    vim.keymap.set('n', '<leader>E', require('oil').open, { desc = 'Open Oil File Explorer' })
  end,
}
