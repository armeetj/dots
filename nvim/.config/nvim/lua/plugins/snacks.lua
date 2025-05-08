return {
  'folke/snacks.nvim',
  priority = 1000,
  config = function()
    require('snacks').setup {
      styles = {
        snacks_image = {
          relative = 'cursor',
          border = 'single',
          focusable = false,
          backdrop = false,
          row = 1,
          col = 1,
          -- width/height are automatically set by the image size unless specified below
        },
      },
      image = {
        doc = {
          enabled = true,
          inline = false,
          float = true,
          max_width = 50,
          max_height = 50,
        },
      },
      scroll = { enabled = true },
    }
  end,
}
