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
        ['gr'] = 'actions.refresh',
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },
      use_default_keymaps = false,
      keymaps_help = {
        border = 'single',
      },
    }
    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open Oil File Explorer' })
  end,
}
