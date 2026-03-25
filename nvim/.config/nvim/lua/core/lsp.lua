-- Python LSP priority: ty > basedpyright > pyright
local python_lsp = vim.fn.executable('ty') == 1 and 'ty'
  or vim.fn.executable('basedpyright-langserver') == 1 and 'basedpyright'
  or 'pyright'

vim.lsp.enable {
  'gopls',
  'lua_ls',
  python_lsp,
  'rust-analyzer',
  'vtsls',
}

-- Space border for seamless padding on floats
local pad_border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }

-- LSP hover with padding
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = pad_border,
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = pad_border,
})

vim.diagnostic.config {
  -- virtual_lines = true,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = pad_border,
    source = true,
  },
  -- signs = {
  --   text = {
  --     [vim.diagnostic.severity.ERROR] = '󰅚 ',
  --     [vim.diagnostic.severity.WARN] = '󰀪 ',
  --     [vim.diagnostic.severity.INFO] = '󰋽 ',
  --     [vim.diagnostic.severity.HINT] = '󰌶 ',
  --   },
  --   numhl = {
  --     [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
  --     [vim.diagnostic.severity.WARN] = 'WarningMsg',
  --   },
  -- },
}
