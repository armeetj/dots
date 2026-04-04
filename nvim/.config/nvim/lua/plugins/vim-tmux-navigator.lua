return {
  source = 'https://github.com/christoomey/vim-tmux-navigator',
  before = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  setup = function()
    if vim.fn.exists(':TmuxNavigateLeft') ~= 2 then
      pcall(vim.cmd.packadd, 'vim-tmux-navigator')
    end

    vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux left' })
    vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Tmux down' })
    vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Tmux up' })
    vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Tmux right' })
  end,
}
