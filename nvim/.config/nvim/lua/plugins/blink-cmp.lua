return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'jc-doyle/cmp-pandoc-references',
    },
    -- use a release tag to download pre-built binaries
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<C-e>'] = { 'hide' },
        ['<C-Space>'] = { 'show' },
        ['<C-y>'] = { 'accept' }, -- accept completion
        ['<Tab>'] = { 'accept' }, -- accept completion
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },

      signature = { enabled = true },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'omni', 'pandoc_references' },
        providers = {
          pandoc_references = {
            name = 'pandoc_references',
            module = 'blink.compat.source',
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
