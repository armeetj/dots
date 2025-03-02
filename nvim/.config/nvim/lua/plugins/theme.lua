return {
  {
    'tinted-theming/tinted-vim',

    -- dark:
    -- ayu mirage
    -- da one black
    -- horizon terminal dark
    -- jabuti
    -- kimber
    -- ocean
    -- terracotta dark
    -- tokyo city terminal dark
    -- vulcan
    -- zenbones
    -- elnawe
    -- catppuccin mocha
    -- ashes
    -- ayu mirage
    -- atalier plataeu light/dark
    --
    -- light:
    -- atalier plataeu
    --
    -- -- colorscheme :: now handled by :Namu colorscheme
    config = function()
      vim.cmd.colorscheme 'base16-black-metal'
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#222222' }) -- for namu fix
      -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#ff0000' }) -- for namu fix
    end,
  },
  { 'atelierbram/Base2Tone-nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'gmr458/cold.nvim' },
}
