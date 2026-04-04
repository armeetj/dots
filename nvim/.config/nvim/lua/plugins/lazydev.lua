return {
  source = 'https://github.com/folke/lazydev.nvim',
  setup = function()
    local ok, lazydev = pcall(require, 'lazydev')
    if not ok then
      return
    end

    lazydev.setup({
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    })
  end,
}
