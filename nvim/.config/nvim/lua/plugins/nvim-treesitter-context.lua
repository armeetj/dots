return {
  source = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
  setup = function()
    local ok, treesitter_context = pcall(require, 'treesitter-context')
    if not ok then
      return
    end

    treesitter_context.setup({
      enable = true,
      multiwindow = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 5,
      trim_scope = 'outer',
      mode = 'topline',
      separator = nil,
      zindex = 20,
      on_attach = nil,
    })
  end,
}
