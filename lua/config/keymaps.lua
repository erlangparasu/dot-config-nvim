-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
-- vim.keymap.set()

map("n", "<leader>e", ":NvimTreeOpen<CR>", { noremap = true, desc = "File Explorer (nvim-tree)" })

if vim.g.neovide then
  -- NOTE: https://github.com/neovide/neovide/issues/1282#issuecomment-2106304616
  -- NOTE: Ctrl+Shift+C to Copy, Ctrl+Shitf+V to paste
  map('v', '<sc-c>', '"+y', { noremap = true })
  map('n', '<sc-v>', 'l"+P', { noremap = true })
  map('v', '<sc-v>', '"+P', { noremap = true })
  map('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  map('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
  map('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })
end

-- Resize window using <ctrl> arrow keys
-- Reference:
-- - https://github.com/LazyVim/LazyVim/blob/060f56d6d429c5ee3fd35f4fa0c152f4a42781ca/lua/lazyvim/config/keymaps.lua#L20
-- - https://github.com/LunarVim/LunarVim/pull/725/files
if vim.fn.has("mac") then
  map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
  map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
  map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
  map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
end

-- map('n', '<leader>ci', [[<cmd>lua require("luasnip.loaders.from_vscode").load({ paths = { "./.vscode" } })<cr>]], {
--   noremap = true,
--   desc = "Load snippets"
-- })

-- NOTE: Run selected text in Terminal
local trim_spaces = true
map("v", "<leader>tL", function()
    require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
end, { desc = "Terminal single line" })
map("v", "<leader>tl", function()
  require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
end, { desc = "Terminal visual lines" })
map("v", "<leader>ts", function()
  require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
end, { desc = "Terminal visual selection" })

-- NOTE: Fix lazygit in Terminal

-- NOTE: Ref: https://github.com/akinsho/toggleterm.nvim/issues/505#issuecomment-1791403431
-- map("n", "<Leader>z", function()
--   local lazygit = require("toggleterm.terminal").Terminal:new({
--       cmd = "lazygit",
--       hidden = true,
--       direction = "float",
--       -- Enable full screen: https://github.com/akinsho/toggleterm.nvim/issues/505
--       float_opts = {
--           width = vim.o.columns,
--           height = vim.o.lines,
--       },
--   })
--   lazygit:toggle()
-- end, { desc = "lazygit in Terminal" })

-- NOTE: Ref: https://github.com/akinsho/toggleterm.nvim/issues/34#issuecomment-966292397
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  hidden = true,
  count = 8,
  --
  cmd = "lazygit",
  display_name = "lazygit",
  direction = "float",
  close_on_exit = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(0, "t", '<esc>', "<cmd>close<CR>", { silent = false, noremap = true })
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gz", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true, desc = "Lazygit Terminal" })
