local M = {}

M.base46 = {
  theme = 'mountain',
  theme_toggle = { 'mountain', 'one_light' },
}

M.ui = {
  cmp = {
    -- lspkind_text = true,
    -- style = 'atom_colored', -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },
  },
  telescope = { style = 'borderless' }, -- borderless / bordered

  statusline = {
    theme = 'minimal', -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = 'default',
    order = nil,
    modules = nil,
  },

  nvdash = {
    load_on_startup = true,
  },

  lsp = { signature = false },

  colorify = {
    enabled = true,
    mode = 'virtual', -- fg, bg, virtual
    virt_text = '󱓻 ',
    highlight = { hex = true, lspvars = true },
  },
}

return M
