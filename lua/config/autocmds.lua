-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- NOTE: Ref: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#open-for-files-and-no-name-buffers
-- NOTE: Ref: https://neovim.io/doc/user/autocmd#autocmd-events
--

-- NOTE: Disable line numbers for terminal buffers
local augroup = vim.api.nvim_create_augroup("TerminalBuffer", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufRead", "TermOpen", "TermEnter" }, {
  group = augroup,
  pattern = "term://*",
  callback = function(event)
    vim.opt_local.number = false
    local buf = event.buf
    vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window", buffer = buf, nowait = true })
    vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Above Window", buffer = buf, nowait = true })
    vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode", buffer = buf, nowait = true })
  end,
})

-- NOTE: Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- NOTE: Switch Session: Define the switch_session function
local function switch_session(old_dir, new_dir)
  -- Ensure the directory path ends with a '/'
  if not old_dir:match("/$") then
    old_dir = old_dir .. "/"
  end

  if not new_dir:match("/$") then
    new_dir = new_dir .. "/"
  end

  local current_session_file = old_dir .. ".session.vim"

  -- Define the new session file path
  local new_session_file = new_dir .. ".session.vim" -- Adjust as needed

  -- Save the current session in the current directory
  vim.cmd("mksession! " .. current_session_file)

  -- Close all open buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.cmd("cd " .. new_dir)

  -- Load the new session from the specified directory
  vim.cmd("source " .. new_session_file)
end

-- Create a command for switch_session
vim.api.nvim_create_user_command("SwitchSession", function(opts, a)
  -- Split the arguments by space
  local args = vim.split(opts.args, ' ')
  -- Access individual arguments
  local arg1 = args[1] or "."
  local arg2 = args[2] or "."
  print("First argument: " .. arg1)
  print("Second argument: " .. arg2)
  switch_session(arg1, arg2)
end, { nargs = "+", complete = "dir" }) -- Complete with directory

-- Example usage
-- You can call this command in Neovim with:
-- :SwitchSession /path/to/your/session/directory

-- NOTE: Load
local function load_session()
  local cwd = vim.fn.getcwd()
  local session_file = cwd .. "/.session.vim" -- Adjust as needed
  vim.cmd("source " .. session_file)
end

vim.api.nvim_create_user_command("LoadSession", function(opts)
  load_session()
end, { nargs = 0 }) -- Complete with directory

-- NOTE: Save
local function save_session()
  local cwd = vim.fn.getcwd()
  local session_file = cwd .. "/.session.vim" -- Adjust as needed
  vim.cmd("mksession! " .. session_file)
end

vim.api.nvim_create_user_command("SaveSession", function(opts)
  save_session()
end, { nargs = 0 }) -- Complete with directory

-- -- NOTE: Auto open nvim-tree when open a buffer
-- local function open_nvim_tree(args)
--   -- buffer is a real file on the disk
--   local real_file = vim.fn.filereadable(args.file) == 1

--   -- buffer is a [No Name]
--   local no_name = args.file == "" and vim.bo[args.buf].buftype == ""

--   if not real_file and not no_name then
--     return
--   end

--   -- open the tree, find the file but don't focus it
--   require("nvim-tree.api").tree.open({ focus = false, find_file = true })
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter", "BufNewFile", "BufRead", "BufReadPost", "SessionLoadPost" }, { callback = open_nvim_tree })

-- NOTE: Auto load snippet *.code-snippets files (from .vscode directory)
-- local function find_code_snippets()
--   local log = require('vlog')
--   local plenary = require('plenary.scandir')
--   local cwd = vim.fn.getcwd()

--   local files = plenary.scan_dir(cwd .. "/.vscode", {
--     depth = 2,
--     hidden = true,
--     search_pattern = ".code[-]snippets$" -- extension ".code-snippets"
--   })

--   if #files > 0 then
--     for _, file in ipairs(files) do
--       -- log.info('- ' .. file)

--       local text1 = file
--       local substring1 = ".code-snippets"

--       if string.find(text1, substring1, 0, true) == nil then
--         -- log.info("  The string does not contain the substring.")
--       else
--         require("luasnip.loaders.from_vscode").load_standalone({ lazy = false, path = file })
--         log.info("  Snippet loaded: " .. file)
--       end
--     end
--   else
--     -- log.info('No .code-snippets files found in the CWD.')
--   end
-- end

-- local function load_snippets_from_workdir(args)
--   local log = require('vlog')

--   -- buffer is a real file on the disk
--   local real_file = vim.fn.filereadable(args.file) == 1

--   -- buffer is a [No Name]
--   local no_name = args.file == "" and vim.bo[args.buf].buftype == ""

--   if not real_file and not no_name then
--     return
--   end

--   -- local cwd = vim.fn.getcwd()
--   -- local current_buffer_dir = vim.fn.expand('%:p:h')

--   -- log.info("current_buffer_dir")
--   -- log.info(current_buffer_dir)

--   find_code_snippets()

--   -- LuaSnip
--   local vscode_dir = vim.fs.find('.vscode', {
--     upward = true,
--     type = 'directory',
--     path = vim.fn.getcwd(),
--     stop = vim.env.HOME,
--   })[1]

--   if vscode_dir then
--     local snippets = vim.fs.find(function(name) return name:match('%.code%-snippets$') end, {
--       limit = 10,
--       type = 'file',
--       path = vscode_dir,
--     })
--     local loader = require('luasnip.loaders.from_vscode')
--     for _, snippet in pairs(snippets) do
--       loader.load_standalone({ lazy = false, path = snippet })
--       log.info("  Snippet loaded again: " .. snippet)
--     end
--   end
-- end

-- vim.api.nvim_create_autocmd({ "VimEnter", "BufNewFile", "BufRead", "BufReadPost", "SessionLoadPost" }, { callback = load_snippets_from_workdir })

-- -- NOTE: Disable highlighter when open .sql file
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "sql",
--   callback = function()
--     -- Disable syntax highlighting for large files
--     vim.cmd[[
--       autocmd BufEnter *.sql set syntax=off
--     ]]
--
--     -- Disable folding for SQL files
--     vim.cmd[[
--       autocmd BufEnter *.sql set nofoldenable
--     ]]
--
--     -- Increase swap file size
--     vim.opt.swapfile = false
--     -- vim.opt.directory = '/tmp//,.'
--     -- vim.opt.updatecount = 100
--     -- vim.opt.undolevels = 0
--
--     -- Disable undo history for SQL files
--     vim.cmd[[
--       autocmd BufEnter *.sql set noundofile
--     ]]
--
--     vim.treesitter.highlighter.active = false
--   end,
-- })

local log = require("nvim-tree.log")

local windows_by_tabpage = {
  previous = {},
  current = {},
}

local function remove_invalid(mapping)
  for t, w in pairs(mapping) do
    if not vim.api.nvim_tabpage_is_valid(t) or not vim.api.nvim_win_is_valid(w) then
      mapping[t] = nil
    end
  end
end

vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
  callback = function(d)
    local tabpage = vim.api.nvim_get_current_tabpage()
    local window = vim.api.nvim_get_current_win()

    -- set previous or current
    if d.event == "WinEnter" then
      windows_by_tabpage.current[tabpage] = window
    elseif d.event == "WinLeave" then
      windows_by_tabpage.previous[tabpage] = window
    end

    -- tidy closed windows/tabs
    remove_invalid(windows_by_tabpage.current)
    remove_invalid(windows_by_tabpage.previous)

    log.line("dev", "%s %s\n", d.event, vim.inspect(windows_by_tabpage))
  end,
})

-- Eof.
