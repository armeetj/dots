return {
  source = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  setup = function()
    local ok, render_markdown = pcall(require, 'render-markdown')
    if not ok then
      return
    end

    render_markdown.setup({
      file_types = { 'markdown', 'Avante' },
      heading = {
        enabled = true,
        width = 'block',
      },
    })
  end,
}
