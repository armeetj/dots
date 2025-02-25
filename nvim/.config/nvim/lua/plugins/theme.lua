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
      vim.cmd.colorscheme 'base16-black-metal-marduk'
    end,
  },
  { 'atelierbram/Base2Tone-nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'gmr458/cold.nvim' },
}
