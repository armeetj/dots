local python_lsp = vim.fn.executable('ty') == 1 and 'ty'
  or vim.fn.executable('basedpyright-langserver') == 1 and 'basedpyright'
  or 'pyright'

local pad_border = 'none'

vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
  config = vim.tbl_extend('force', config or {}, { border = pad_border })
  return vim.lsp.handlers.hover(err, result, ctx, config)
end

vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
  config = vim.tbl_extend('force', config or {}, { border = pad_border })
  return vim.lsp.handlers.signature_help(err, result, ctx, config)
end

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = pad_border,
    source = true,
  },
})

vim.lsp.enable({
  'gopls',
  'lua_ls',
  python_lsp,
  'rust_analyzer',
  'vtsls',
})
