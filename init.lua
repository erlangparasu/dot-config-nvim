-- bootstrap lazy.nvim, LazyVim and your plugins

-- vim.opt.verbose = 1
-- vim.loglevel = 'debug'
-- vim.logfile = '/Users/ganeshcom/.config/nvim/nvim.log'

if vim.g.vscode then
  -- require("config.lazy")
elseif vim.g.neovide then
  -- vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_cursor_vfx_mode = "wireframe"

  require("config.lazy")
else
  require("config.lazy")
end
