return {
  source = 'https://github.com/stevearc/conform.nvim',
  setup = function()
    local ok, conform = pcall(require, 'conform')
    if not ok then
      return
    end

    conform.setup({
      notify_on_error = true,
      formatters_by_ft = {
        python = { 'ruff_format', 'ruff_organize_imports' },
        tex = { 'latexindent' },
        lua = { 'stylua' },
        go = { 'goimports', 'golines', 'gofmt' },
      },
      format_on_save = {
        lsp_format = 'fallback',
        async = false,
      },
    })
  end,
}
