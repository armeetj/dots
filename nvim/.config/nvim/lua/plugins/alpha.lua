return {
  source = 'https://github.com/goolord/alpha-nvim',
  setup = function()
    local ok, alpha = pcall(require, 'alpha')
    if not ok then
      return
    end

    alpha.setup(require('alpha.themes.theta').config)
  end,
}
