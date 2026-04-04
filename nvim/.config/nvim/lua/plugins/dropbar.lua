return {
  source = 'https://github.com/Bekaboo/dropbar.nvim',
  setup = function()
    local ok, dropbar_api = pcall(require, 'dropbar.api')
    if not ok then
      return
    end

    vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
