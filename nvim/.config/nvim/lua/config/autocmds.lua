-- Match FloatBorder bg to NormalFloat for seamless padding
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('float-border-bg', { clear = true }),
  callback = function()
    local bg = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).bg
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = bg })
  end,
})
-- Run once for the initial colorscheme
local bg = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).bg
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = bg })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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

    -- defaults:
    -- https://neovim.io/doc/user/news-0.11.html#_defaults

    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gh', vim.lsp.buf.hover, 'Hover Documentation')
    map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
    map('g.', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>lr', vim.lsp.buf.rename, 'Rename all references')
    map('<leader>lf', function()
      require('conform').format { async = true, lsp_format = 'fallback' }
    end, 'Format')
    map('<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', 'Goto Definition in Vertical Split')
    map('<leader>h', '<cmd>split | lua vim.lsp.buf.definition()<cr>', 'Goto Definition in Horizontal Split')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      -- When cursor stops moving: Highlights all instances of the symbol under the cursor
      -- When cursor moves: Clears the highlighting
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- When LSP detaches: Clears the highlighting
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})
