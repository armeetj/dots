return {
  'EtiamNullam/deferred-clipboard.nvim',
  event = 'VeryLazy',
  config = function()
    require('deferred-clipboard').setup()
  end,
}
