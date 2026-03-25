vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  local ok, hlslens = pcall(require, "hlslens")
  if ok then hlslens.stop() end
end, { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
