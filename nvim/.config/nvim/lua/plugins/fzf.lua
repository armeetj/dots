return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {},
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup {
      { 'telescope' },
      winopts = {
        -- fullscreen = true,
        border = 'single',
        preview = {
          border = 'single',
        },
      },
    }

    -- register as ui select
    fzf.register_ui_select()

    -- search <...>
    vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sc', fzf.commands, { desc = '[S]earch [C]ommand' })
    vim.keymap.set('v', '<leader>sv', fzf.grep_visual, { desc = '[S]earch [V]isual Selection' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sW', fzf.grep_cWORD, { desc = '[S]earch current [W]ORD' })
    vim.keymap.set('n', '<leader>sg', fzf.grep_project, { desc = '[S]earch [G]rep Project' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch Document [D]iagnostics' })
    vim.keymap.set('n', '<leader>sD', fzf.diagnostics_workspace, { desc = '[S]earch Workspace [D]iagnostics' })
    vim.keymap.set('n', '<leader>sq', fzf.grep_quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>sj', fzf.jumps, { desc = '[S]earch [J]umplist' })
    vim.keymap.set('n', '<leader>sm', fzf.marks, { desc = '[S]earch [M]arks' })
    vim.keymap.set('n', '<leader>sr', fzf.registers, { desc = '[S]earch [R]egisters' })
    vim.keymap.set('n', '<leader>sR', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', 'z=', fzf.spell_suggest, { desc = 'Spelling suggestions' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

    -- git specific
    vim.keymap.set('n', '<leader>gf', fzf.git_files, { desc = '[G]it [F]iles' })
    vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = '[G]it [S]tatus' })
    vim.keymap.set('n', '<leader>gc', fzf.git_bcommits, { desc = '[G]it [C]ommit <buffer>' })
    vim.keymap.set('n', '<leader>gC', fzf.git_commits, { desc = '[G]it [C]ommit <project>' })
    vim.keymap.set('n', '<leader>gst', fzf.git_stash, { desc = '[G]it [S][T]ash' })

    vim.keymap.set('n', '<leader>/', function()
      fzf.grep_curbuf { fzf_opts = { ['--layout'] = 'reverse-list' } }
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- vim.keymap.set('n', '<leader>s/', function()
    --   fzf.grep_project {
    --     prompt = 'Live Grep in Open Files',
    --     rg_opts = '--files-with-matches',
    --   }
    -- end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
