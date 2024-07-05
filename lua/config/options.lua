-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- NOTE: Sync with system clipboard
-- vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.clipboard='unnamedplus'

vim.opt.relativenumber = false

vim.o.guifont = "JetBrainsMonoNL Nerd Font:h13" -- text below applies for VimScript

vim.opt.sessionoptions = {
  -- "blank",
  "buffers",
  "curdir",
  -- "folds",
  -- "globals",
  -- "help",
  -- "localoptions",
  -- "options",
  -- "skiprtp",
  "resize",
  -- "sesdir",
  "tabpages",
  "terminal",
  "winpos",
  "winsize",
}

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
vim.g.lazyvim_php_lsp = "intelephense"

