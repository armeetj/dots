return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        f = require('mini.ai').gen_spec.treesitter {
          a = '@function.outer', -- Selects the whole function (with keyword, body, etc.)
          i = '@function.inner', -- Selects the inside of the function (just the body)
        },
        c = require('mini.ai').gen_spec.treesitter {
          a = '@class.outer', -- Selects the whole function (with keyword, body, etc.)
          i = '@class.inner', -- Selects the inside of the function (just the body)
        },
      },
    }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.pairs').setup()

    require('mini.completion').setup()

    require('mini.icons').setup()

    require('mini.bracketed').setup()

    require('mini.indentscope').setup {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    }

    -- Animations
    -- require('mini.animate').setup()

    -- -- Simple and easy statusline.
    -- --  You could remove this setup call if you don't like it,
    -- --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    require('mini.files').setup {}

    vim.keymap.set('n', '<leader>e', require('mini.files').open, { desc = 'Open Mini File Explorer' })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
