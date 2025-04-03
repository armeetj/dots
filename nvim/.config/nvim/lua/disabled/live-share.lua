return {
  'azratul/live-share.nvim',
  dependencies = {
    'jbyuki/instant.nvim',
  },
  config = function()
    vim.g.instant_username = 'armeetj'
    require('live-share').setup {
      port_internal = 9876,
      max_attempts = 40, -- 10 seconds
      service = 'serveo.net',
    }
  end,
}
