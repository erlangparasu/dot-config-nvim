-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Reference: https://github.com/folke/persistence.nvim/blob/5fe077056c821aab41f87650bd6e1c48cd7dd047/README.md?plain=1#L54
-- map("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

map("n", "<leader>fo", ":NvimTreeOpen<CR>", { noremap = true, desc = "Open File Tree" })

if vim.g.neovide then
    -- NOTE: https://github.com/neovide/neovide/issues/1282#issuecomment-2106304616
    -- NOTE: Ctrl+Shift+C to Copy, Ctrl+Shitf+V to paste
    map('v', '<sc-c>', '"+y', {noremap = true})
	map('n', '<sc-v>', 'l"+P', {noremap = true})
	map('v', '<sc-v>', '"+P', {noremap = true})
	map('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', {noremap = true})
	map('i', '<sc-v>', '<ESC>l"+Pli', {noremap = true})
	map('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true})
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
