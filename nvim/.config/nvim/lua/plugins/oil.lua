return {
  source = 'https://github.com/stevearc/oil.nvim',
  setup = function()
    local ok, oil = pcall(require, 'oil')
    if not ok then
      return
    end

    local function set_permissions_highlights()
      vim.api.nvim_set_hl(0, 'OilPermissionsRead', { link = 'String' })
      vim.api.nvim_set_hl(0, 'OilPermissionsWrite', { link = 'WarningMsg' })
      vim.api.nvim_set_hl(0, 'OilPermissionsExecute', { link = 'Function' })
      vim.api.nvim_set_hl(0, 'OilPermissionsNone', { link = 'Comment' })
    end

    set_permissions_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('oil-permissions-highlights', { clear = true }),
      callback = set_permissions_highlights,
    })

    pcall(function()
      local columns = require('oil.columns')
      local constants = require('oil.constants')
      local permissions = require('oil.adapters.files.permissions')
      local FIELD_META = constants.FIELD_META

      columns.register('permissions_color', {
        require_stat = true,
        render = function(entry)
          local meta = entry[FIELD_META]
          local stat = meta and meta.stat
          if not stat then
            return columns.EMPTY
          end

          local value = permissions.mode_to_str(stat.mode)
          local highlights = {}
          for i = 1, #value do
            local char = value:sub(i, i)
            local group = 'OilPermissionsNone'
            if char == 'r' then
              group = 'OilPermissionsRead'
            elseif char == 'w' then
              group = 'OilPermissionsWrite'
            elseif char:match('[xstST]') then
              group = 'OilPermissionsExecute'
            end
            highlights[#highlights + 1] = { group, i - 1, i }
          end

          return { value, highlights }
        end,
        parse = function(line)
          return permissions.parse(line)
        end,
      })
    end)

    oil.setup({
      view_options = { show_hidden = true },
      columns = {
        'icon',
        'permissions_color',
        'size',
        'mtime',
      },
      delete_to_trash = true,
      watch_for_changes = true,
      skip_confirm_for_simple_edits = true,
      confirmation = {
        border = 'none',
      },
      progress = {
        border = 'none',
      },
      ssh = {
        border = 'none',
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
        border = 'none',
      },
    })

    vim.keymap.set('n', '-', oil.open, { desc = 'Open file explorer' })
  end,
}
