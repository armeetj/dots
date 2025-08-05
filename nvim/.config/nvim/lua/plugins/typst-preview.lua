return {
  'chomosuke/typst-preview.nvim',
  event = 'VeryLazy',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  opts = {
    -- invert_colors = 'always',
  }, -- lazy.nvim will implicitly calls `setup {}`
}
