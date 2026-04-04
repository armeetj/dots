return {
  source = 'https://github.com/leath-dub/snipe.nvim',
  setup = function()
    local ok, snipe = pcall(require, 'snipe')
    if not ok then
      return
    end

    snipe.setup({
      ui = {
        open_win_override = {
          border = 'none',
        },
        persist_tags = false,
      },
      hints = {
        dictionary = '1234567890asfghl;wertyuiop',
      },
      navigate = {
        cancel_snipe = 'q',
        close_buffer = 'd',
        open_vsplit = 'v',
        open_split = 'h',
        change_tag = 'c',
      },
      sort = 'default',
    })

    vim.keymap.set('n', 'gb', function()
      snipe.open_buffer_menu()
    end, { desc = 'Open buffer menu' })
  end,
}
