return {
  source = 'https://github.com/folke/todo-comments.nvim',
  setup = function()
    local ok, todo_comments = pcall(require, 'todo-comments')
    if not ok then
      return
    end

    todo_comments.setup({
      signs = true,
    })
  end,
}
