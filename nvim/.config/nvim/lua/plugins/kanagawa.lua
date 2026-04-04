return {
  source = 'https://github.com/rebelot/kanagawa.nvim',
  setup = function()
    pcall(function()
      require('kanagawa').load('dragon')
    end)
  end,
}
