-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- NOTE: Ref: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#open-for-files-and-no-name-buffers
local function open_nvim_tree(args)
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(args.file) == 1

  -- buffer is a [No Name]
  local no_name = args.file == "" and vim.bo[args.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.open({ focus = false, find_file = true })
end

-- NOTE: Ref: https://neovim.io/doc/user/autocmd#autocmd-events
vim.api.nvim_create_autocmd({ "VimEnter", "BufNewFile", "BufRead", "BufReadPost", "SessionLoadPost" }, { callback = open_nvim_tree })
