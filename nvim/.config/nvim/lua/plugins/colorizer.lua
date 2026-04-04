return {
  source = 'https://github.com/catgoose/nvim-colorizer.lua',
  setup = function()
    local ok, colorizer = pcall(require, 'colorizer')
    if not ok then
      return
    end

    colorizer.setup({})
  end,
}
