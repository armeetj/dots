return {
  source = 'https://github.com/lewis6991/gitsigns.nvim',
  setup = function()
    local ok, gitsigns = pcall(require, 'gitsigns')
    if not ok then
      return
    end

    gitsigns.setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 200,
        virt_text_pos = 'right_align',
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
    })
  end,
}
