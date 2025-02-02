return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    enable = true, -- Enable this plugin (can be toggled later via commands)
    multiwindow = false, -- Enable multiwindow support
    max_lines = 0, -- No limit on the number of context lines
    min_window_height = 0, -- No minimum window height required to show context
    line_numbers = true, -- Show line numbers in context
    multiline_threshold = 10, -- Max lines for a single context
    trim_scope = 'outer', -- Trim outer context if max_lines is exceeded
    mode = 'cursor', -- Context based on cursor position
    separator = nil, -- No separator between context and content
    zindex = 20, -- Z-index of the context window
    on_attach = nil, -- Optional: return false to disable attaching for certain buffers
  },
}
