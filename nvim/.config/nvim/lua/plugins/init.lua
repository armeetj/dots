local plugin_names = {
  'plugins.alpha',
  'plugins.blink',
  'plugins.bullets',
  'plugins.colorizer',
  'plugins.conform',
  'plugins.dropbar',
  'plugins.fidget',
  'plugins.gitsigns',
  'plugins.kanagawa',
  'plugins.lazydev',
  'plugins.mini',
  'plugins.marks',
  'plugins.nvim-hlslens',
  'plugins.nvim-treesitter',
  'plugins.nvim-treesitter-context',
  'plugins.nvim-lspconfig',
  'plugins.plenary',
  'plugins.oil',
  'plugins.nvim-ufo',
  'plugins.render-markdown',
  'plugins.snipe',
  'plugins.todo-comments',
  'plugins.vim-sleuth',
  'plugins.vim-tmux-navigator',
  'plugins.which-key',
}

local plugins = {}
for _, name in ipairs(plugin_names) do
  plugins[#plugins + 1] = require(name)
end

for _, plugin in ipairs(plugins) do
  if plugin.before then
    plugin.before()
  end
end

local sources = {}
for _, plugin in ipairs(plugins) do
  if plugin.sources then
    vim.list_extend(sources, plugin.sources)
  else
    sources[#sources + 1] = plugin.source
  end
end

vim.pack.add(sources, {
  confirm = false,
  load = true,
})

for _, plugin in ipairs(plugins) do
  if plugin.setup then
    plugin.setup()
  end
end
