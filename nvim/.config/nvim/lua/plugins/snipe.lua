return {
  'leath-dub/snipe.nvim',
  keys = {
    {
      'gb',
      function()
        require('snipe').open_buffer_menu()
      end,
      desc = 'Open Snipe buffer menu',
    },
  },
  config = function()
    local snipe = require 'snipe'

    snipe.setup {
      hints = {
        -- Characters to use for hints
        dictionary = '1234567890asfghl;wertyuiop',
      },
      navigate = {
        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        -- cancel_snipe = '<esc>',
        cancel_snipe = 'q',

        -- Remove "j" and "k" from your dictionary to navigate easier to delete
        -- Close the buffer under the cursor
        -- NOTE: Make sure you don't use the character below on your dictionary
        close_buffer = 'd',

        -- Open buffer in vertical split
        open_vsplit = 'v',

        -- Open buffer in split, based on `vim.opt.splitbelow`
        open_split = 'h',

        -- Change tag manually
        change_tag = 'c',
      },
      -- Define the way buffers are sorted by default
      -- Can be any of "default" (sort buffers by their number) or "last" (sort buffers by last accessed)
      -- If you choose "last", it will be modifying sorting the boffers by last
      -- accessed, so the "a" will always be assigned to your latest accessed
      -- buffer
      -- If you want the letters not to change, leave the sorting at default
      sort = 'default',
    }
    -- vim.keymap.set(
    --   "n",
    --   "gba",
    --   snipe.create_buffer_menu_toggler({
    --     -- Limit the width of path buffer names
    --     max_path_width = 2,
    --   }),
    --   { desc = "[P]Snipe" }
    -- )
    --
    --
    -- wrap vim ui select with snipe
    snipe.ui_select_menu = require('snipe.menu'):new { position = 'center' }
    snipe.ui_select_menu:add_new_buffer_callback(function(m)
      vim.keymap.set('n', '<esc>', function()
        m:close()
      end, { nowait = true, buffer = m.buf })
    end)
    vim.ui.select = snipe.ui_select
  end,
}
