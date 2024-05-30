-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
    -- require("config.lazy")
elseif vim.g.neovide then
    require("config.lazy")

    -- NOTE: https://github.com/neovide/neovide/issues/1282#issuecomment-2106304616
    -- NOTE: Ctrl+Shift+C to Copy, Ctrl+Shitf+V to paste
    vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', {noremap = true})
	vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', {noremap = true})
	vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', {noremap = true})
	vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', {noremap = true})
	vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', {noremap = true})
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', {noremap = true})
else
    require("config.lazy")
end
