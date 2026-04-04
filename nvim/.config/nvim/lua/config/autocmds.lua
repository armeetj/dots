vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('gh', vim.lsp.buf.hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Help')
    map('g.', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>lr', vim.lsp.buf.rename, 'Rename')
    map('<leader>lf', function()
      local ok, conform = pcall(require, 'conform')
      if ok then
        conform.format({ async = true, lsp_format = 'fallback' })
      else
        vim.lsp.buf.format({ async = true })
      end
    end, 'Format')
    map('<leader>ds', function()
      local ok, extra = pcall(require, 'mini.extra')
      if ok then
        extra.pickers.lsp({ scope = 'document_symbol' })
      else
        vim.lsp.buf.document_symbol()
      end
    end, 'Document Symbols')
    map('<leader>ws', function()
      local ok, extra = pcall(require, 'mini.extra')
      if ok then
        extra.pickers.lsp({ scope = 'workspace_symbol_live' })
      else
        vim.lsp.buf.workspace_symbol('')
      end
    end, 'Workspace Symbols')
    map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', 'Definition in Vertical Split')
    map('<leader>h', '<cmd>split | lua vim.lsp.buf.definition()<cr>', 'Definition in Horizontal Split')
  end,
})
