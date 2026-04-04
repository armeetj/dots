return {
  source = 'https://github.com/chentoast/marks.nvim',
  setup = function()
    local ok, marks = pcall(require, 'marks')
    if not ok then
      return
    end

    marks.setup({})
  end,
}
