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

vim.o.showtabline = 2

-- NOTE: PHP

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
vim.g.lazyvim_php_lsp = "intelephense"

-- NOTE: Neovide

vim.g.neovide_input_macos_option_key_is_meta = 'both'
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = true
-- vim.g.neovide_cursor_animation_length = 0.5
-- vim.g.neovide_cursor_trail_size = 0.5

-- Eof.
