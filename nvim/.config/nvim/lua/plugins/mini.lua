return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
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
    require('mini.surround').setup {
      mappings = {
        add = 's', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
    require('mini.icons').setup()
    require('mini.bracketed').setup()
    require('mini.indentscope').setup {
      symbol = '│',
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
        -- animation = require('mini.indentscope').gen_animation.quadratic { easing = 'out', duration = 100, unit = 'total' },
      },
      options = { try_as_border = true, indent_at_cursor = true },
    }
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
