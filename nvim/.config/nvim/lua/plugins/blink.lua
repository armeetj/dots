return {
  sources = {
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/saghen/blink.cmp',
  },
  setup = function()
    local function set_blink_highlights()
      local normal_float = vim.api.nvim_get_hl(0, { name = 'NormalFloat', link = false })
      local float_border = vim.api.nvim_get_hl(0, { name = 'FloatBorder', link = false })
      local cursor_line = vim.api.nvim_get_hl(0, { name = 'CursorLine', link = false })
      local pmenu_extra = vim.api.nvim_get_hl(0, { name = 'PmenuExtra', link = false })
      local pmenu_kind = vim.api.nvim_get_hl(0, { name = 'PmenuKind', link = false })

      vim.api.nvim_set_hl(0, 'BlinkCmpMenu', {
        fg = normal_float.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', {
        fg = float_border.fg,
        bg = float_border.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', {
        bg = cursor_line.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpLabel', {
        fg = normal_float.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpLabelDeprecated', {
        fg = pmenu_extra.fg,
        bg = normal_float.bg,
        strikethrough = true,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpLabelDetail', {
        fg = pmenu_extra.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpLabelDescription', {
        fg = pmenu_extra.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpKind', {
        fg = pmenu_kind.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpSource', {
        fg = pmenu_extra.fg,
        bg = normal_float.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpScrollBarThumb', {
        bg = cursor_line.bg,
      })
      vim.api.nvim_set_hl(0, 'BlinkCmpScrollBarGutter', {
        bg = normal_float.bg,
      })
    end

    local ok, blink = pcall(require, 'blink.cmp')
    if not ok then
      return
    end

    blink.setup({
      snippets = { preset = 'luasnip' },
      signature = {
        enabled = true,
        window = {
          border = 'none',
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal',
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          cmdline = {
            min_keyword_length = 2,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      keymap = {
        ['<C-f>'] = {},
      },
      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
        keymap = {
          ['<CR>'] = { 'accept_and_enter', 'fallback' },
        },
      },
      completion = {
        menu = {
          border = 'none',
          scrolloff = 1,
          scrollbar = false,
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
              { 'source_name' },
            },
          },
        },
        documentation = {
          window = {
            border = 'none',
            scrollbar = false,
            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          },
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
    })

    set_blink_highlights()
    vim.schedule(set_blink_highlights)
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('blink-theme-overrides', { clear = true }),
      callback = set_blink_highlights,
    })
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('blink-theme-overrides-enter', { clear = true }),
      callback = set_blink_highlights,
    })

    pcall(function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end)
  end,
}
