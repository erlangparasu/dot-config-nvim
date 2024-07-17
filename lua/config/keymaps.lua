-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
-- vim.keymap.set()

-- NOTE: nvim-tree --------------------------------------------------

map("n", "<leader>e", ":NvimTreeOpen<CR>", { noremap = true, desc = "File Explorer (nvim-tree) Open" })
map("n", "<leader>E", ":NvimTreeClose<CR>", { noremap = true, desc = "File Explorer (nvim-tree) Close" })

-- NOTE: toggleterm-manager -----------------------------------------

function Fun_Open_ToggleTerm_Manager()
  vim.cmd(':Telescope toggleterm_manager')
end
vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua Fun_Open_ToggleTerm_Manager()<CR>", { noremap = true, silent = true, desc = "ToggleTerm Manager" })

-- NOTE: Telescope tabs ---------------------------------------------
function Fun_Telescope_Tabs()
  vim.cmd(':Telescope telescope-tabs list_tabs')
end
vim.api.nvim_set_keymap("n", "<leader><tab>m", "<cmd>lua Fun_Telescope_Tabs()<CR>", { noremap = true, silent = true, desc = "Telescope Tabs Manager" })

-- NOTE: telescope-search-dir-picker --------------------------------

vim.api.nvim_set_keymap("n", "<leader>si", "<cmd>:Telescope search_dir_picker<CR>", { noremap = true, silent = true, desc = "Search text in directory" })

-- NOTE: neovide ----------------------------------------------------

-- if vim.g.neovide then
--   -- NOTE: https://github.com/neovide/neovide/issues/1282#issuecomment-2106304616
--   -- NOTE: Ctrl+Shift+C to Copy, Ctrl+Shitf+V to paste
--   map('v', '<sc-c>', '"+y', { noremap = true })
--   map('n', '<sc-v>', 'l"+P', { noremap = true })
--   map('v', '<sc-v>', '"+P', { noremap = true })
--   map('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
--   map('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
--   map('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })
-- end

if vim.g.neovide then
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- NOTE: clipboard --------------------------------------------------

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- NOTE: macos window -----------------------------------------------

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

-- NOTE: toggleterm -------------------------------------------------

-- NOTE: Run selected text in Terminal
local trim_spaces = true

-- map("v", "<leader>t1", function()
--     require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
-- end, { desc = "Execute line in terminal" })

map("v", "<leader>te", function()
  require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
end, { desc = "Execute lines in terminal" })

map("v", "<leader>tE", function()
  require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
end, { desc = "Execute selected in terminal" })

-- NOTE: lazygit ----------------------------------------------------

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

function Custom_Lazygit_Toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>lua Custom_Lazygit_Toggle()<CR>", { noremap = true, silent = true, desc = "Lazygit Terminal" })
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>lua Custom_Lazygit_Toggle()<CR>", { noremap = true, silent = true, desc = "Lazygit Terminal" })
vim.api.nvim_set_keymap("n", "<leader>gy", "<cmd>lua Custom_Lazygit_Toggle()<CR>", { noremap = true, silent = true, desc = "Lazygit Terminal" })
vim.api.nvim_set_keymap("n", "<leader>gz", "<cmd>lua Custom_Lazygit_Toggle()<CR>", { noremap = true, silent = true, desc = "Lazygit Terminal" })

-- NOTE: Load *.code-snippets files (from .vscode directory) --------

local function _load_code_snippets()
  local log = require('vlog')
  local plenary = require('plenary.scandir')
  local cwd = vim.fn.getcwd()

  local files = plenary.scan_dir(cwd .. "/.vscode", {
    depth = 2,
    hidden = true,
    search_pattern = ".code[-]snippets$" -- extension ".code-snippets"
  })

  if #files > 0 then
    for _, file in ipairs(files) do
      -- log.info('- ' .. file)

      local text1 = file
      local substring1 = ".code-snippets"

      if string.find(text1, substring1, 0, true) == nil then
        -- log.info("  The string does not contain the substring.")
      else
        require("luasnip.loaders.from_vscode").load_standalone({ lazy = false, path = file })
        log.info("  Snippet loaded: " .. file)
      end
    end
  else
    -- log.info('No .code-snippets files found in the CWD.')
  end


  -- LuaSnip
  local vscode_dir = vim.fs.find('.vscode', {
    upward = true,
    type = 'directory',
    path = vim.fn.getcwd(),
    stop = vim.env.HOME,
  })[1]

  if vscode_dir then
    local snippets = vim.fs.find(function(name) return name:match('%.code%-snippets$') end, {
      limit = 10,
      type = 'file',
      path = vscode_dir,
    })
    local loader = require('luasnip.loaders.from_vscode')
    for _, snippet in pairs(snippets) do
      loader.load_standalone({ lazy = false, path = snippet })
      log.info("  Snippet loaded again: " .. snippet)
    end
  end
end

vim.keymap.set("n", "<leader>fS", _load_code_snippets, { noremap = true, silent = true, desc = "Load .vscode snippets" })

-- --
-- vim.keymap.set({"i"}, "<C-X>", '<Cmd>lua require("luasnip").expand()<CR>', { noremap = true, silent = true, desc = "my custom 1" })
-- vim.keymap.set({"i", "s"}, "<M-L>", '<Cmd>lua require("luasnip").jump( 1)<CR>', { noremap = true, silent = true, desc = "my custom 2" })
-- vim.keymap.set({"i", "s"}, "<M-J>", '<Cmd>lua require("luasnip").jump(-1)<CR>', { noremap = true, silent = true, desc = "my custom 3" })

-- --
-- vim.keymap.set({"i"}, "<C-Z>", '<Cmd>lua require("cmp").mapping.complete()<CR>', { noremap = true, silent = true, desc = "my custom 4" })

-- NOTE: Open Yazi --------------------------------------------------

local my_terminal = require("toggleterm.terminal").Terminal
local my_yazi_term = my_terminal:new({
  hidden = true,
  count = 9,
  --
  cmd = 'touch "$HOME/.tmp-yazi-cwd.txt"; yazi --cwd-file="$HOME/.tmp-yazi-cwd.txt"',
  display_name = "Yazi",
  direction = "float",
  close_on_exit = true,
  on_open = function(term)
    print("on_open")
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(0, "t", '<esc>', "<cmd>close<CR>", { silent = false, noremap = true })
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
  on_close = function(term)
    local my_str = vim.trim(vim.fn.system('cat $HOME/.tmp-yazi-cwd.txt'))
    print("on_close: " .. my_str)

    -- Change the Tab's current working directory to the selected directory
    vim.cmd("tcd " .. my_str)
    vim.schedule(function()
      vim.cmd("tcd " .. my_str)
      vim.cmd("verbose pwd")
    end)

    print("yazi close: " .. my_str)
  end,
  on_exit = function()
    local my_str = vim.trim(vim.fn.system('cat $HOME/.tmp-yazi-cwd.txt'))
    print("on_exit: " .. my_str)

    -- Change the Tab's current working directory to the selected directory
    vim.cmd("tcd " .. my_str)
    vim.schedule(function()
      vim.cmd("tcd " .. my_str)
      vim.cmd("verbose pwd")
    end)

    print("yazi exit: " .. my_str)
  end,
})

function My_yazi_terminal_toggle()
  my_yazi_term:toggle()
end

vim.keymap.set("n", "<leader>y", My_yazi_terminal_toggle, { noremap = true, silent = true, desc = "Select for :tcd using yazi" })

-- NOTE: Change window current dir (lcd) -----------------------------

function My_lcd()
  local my_str = vim.trim(vim.fn.system('cat $HOME/.tmp-yazi-cwd.txt'))
  print('tmp yazi cwd: ' .. my_str)

  -- Change the current working directory to the selected directory
  vim.cmd("lcd " .. my_str)
  vim.schedule(function()
    vim.cmd("lcd " .. my_str)
    vim.cmd("verbose pwd")
  end)

  print("lcd to: " .. my_str)
end

vim.keymap.set("n", "<leader>Y", My_lcd, { noremap = true, silent = true, desc = "Apply for :lcd" })

-- EOF
