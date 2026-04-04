return {
  source = 'https://github.com/folke/which-key.nvim',
  setup = function()
    local ok, which_key = pcall(require, 'which-key')
    if not ok then
      return
    end

    which_key.setup({
      show_help = false,
      preset = 'helix',
      delay = 100,
      win = {
        border = 'none',
        padding = { 0, 0 },
      },
      icons = {
        separator = ' ',
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = 'UP ',
          Down = 'DN ',
          Left = 'LEFT ',
          Right = 'RIGH ',
          C = 'C-… ',
          M = 'M-… ',
          D = 'D-… ',
          S = 'S-… ',
          CR = 'CR ',
          Esc = 'ESC ',
          ScrollWheelDown = 'SCRLDN ',
          ScrollWheelUp = 'SCRLUP ',
          NL = 'NL ',
          BS = 'BS ',
          Space = 'SPC ',
          Tab = 'TAB ',
          F1 = 'F1',
          F2 = 'F2',
          F3 = 'F3',
          F4 = 'F4',
          F5 = 'F5',
          F6 = 'F6',
          F7 = 'F7',
          F8 = 'F8',
          F9 = 'F9',
          F10 = 'F10',
          F11 = 'F11',
          F12 = 'F12',
        },
      },
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
      },
    })
  end,
}
