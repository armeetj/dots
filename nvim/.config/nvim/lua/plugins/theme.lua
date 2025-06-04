return {
  {
    'tinted-theming/tinted-vim',
    enabled=true,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'base16-tokyo-city-light'
      -- vim.cmd.colorscheme 'base16-black-metal-marduk'
      vim.cmd.colorscheme 'base16-default-dark'
    end,
  },
  -- { 'atelierbram/Base2Tone-nvim' },
  -- { 'rose-pine/neovim', name = 'rose-pine' },
  -- { 'nyoom-engineering/oxocarbon.nvim' },
  -- { 'gmr458/cold.nvim' },
  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.cmd.colorscheme 'tokyonight'
  --   end,
  -- },
}
