-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
    -- require("config.lazy")
elseif vim.g.neovide then
    require("config.lazy")
else
    require("config.lazy")
end
