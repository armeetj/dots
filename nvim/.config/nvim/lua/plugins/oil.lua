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
        'permissions',
        'size',
        'mtime',
      },
      delete_to_trash = true,
      watch_for_changes = true,
      skip_confirm_for_simple_edits = true,
      confirmation = {
        border = 'single',
      },
      progress = {
        border = 'single',
      },
      ssh = {
        border = 'single',
      },
      keymaps = {
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
      },
      keymaps_help = {
        border = 'single',
      },
    }
    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open Oil File Explorer' })
  end,
}
