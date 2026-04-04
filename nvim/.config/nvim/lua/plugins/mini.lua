return {
  source = 'https://github.com/echasnovski/mini.nvim',
  setup = function()
    local ok_pick, pick = pcall(require, 'mini.pick')
    if ok_pick then
      pick.setup({
        window = {
          config = {
            border = 'none',
          },
        },
      })

      vim.keymap.set('n', '<C-p>', function()
        MiniPick.builtin.files()
      end, { desc = 'Find files' })

      vim.keymap.set('n', '<leader>f', function()
        MiniPick.builtin.files()
      end, { desc = 'Find files' })

      vim.keymap.set('n', '<leader>F', function()
        MiniPick.builtin.cli({
          command = { 'fd', '--type=f', '--color=never', '--hidden', '--exclude=.git' },
        }, {
          source = {
            name = 'Files (hidden)',
          },
        })
      end, { desc = 'Find files (hidden)' })

      vim.keymap.set('n', '<leader>/', function()
        MiniPick.builtin.grep_live()
      end, { desc = 'Grep' })

      vim.keymap.set('n', '<leader>,', function()
        MiniPick.builtin.buffers()
      end, { desc = 'Buffers' })
    end

    local ok_ai, ai = pcall(require, 'mini.ai')
    if ok_ai then
      ai.setup({
        n_lines = 500,
      })
    end

    local ok_cursorword, cursorword = pcall(require, 'mini.cursorword')
    if ok_cursorword then
      cursorword.setup()

      local function set_cursorword_highlights()
        local visual = vim.api.nvim_get_hl(0, { name = 'Visual', link = false })

        vim.api.nvim_set_hl(0, 'MiniCursorword', {
          bg = visual.bg,
          underline = false,
        })
        vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', {
          bg = visual.bg,
          underline = false,
          nocombine = true,
        })
      end

      set_cursorword_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('mini-cursorword-highlights', { clear = true }),
        callback = set_cursorword_highlights,
      })
    end

    local ok_diff, diff = pcall(require, 'mini.diff')
    if ok_diff then
      diff.setup()
    end

    local ok_surround, surround = pcall(require, 'mini.surround')
    if ok_surround then
      surround.setup({
        mappings = {
          add = 's',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',
          suffix_last = 'l',
          suffix_next = 'n',
        },
      })
    end

    local ok_icons, icons = pcall(require, 'mini.icons')
    if ok_icons then
      icons.setup()
    end

    local ok_bracketed, bracketed = pcall(require, 'mini.bracketed')
    if ok_bracketed then
      bracketed.setup()
    end

    local ok_indentscope, indentscope = pcall(require, 'mini.indentscope')
    if ok_indentscope then
      indentscope.setup({
        symbol = '│',
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
        options = { try_as_border = true, indent_at_cursor = true },
      })
    end

    local ok_statusline, statusline = pcall(require, 'mini.statusline')
    if ok_statusline then
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end
  end,
}
