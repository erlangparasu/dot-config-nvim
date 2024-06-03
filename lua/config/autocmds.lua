-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local log = require('vlog')

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

-- NOTE: erlangparasu 2024
local function load_snippets_from_workdir(args)

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(args.file) == 1
  -- log.info("1")

  -- buffer is a [No Name]
  local no_name = args.file == "" and vim.bo[args.buf].buftype == ""
  -- log.info("2")

  if not real_file and not no_name then
    -- log.info("3")
    return
  end

  -- require("luasnip.loaders.from_vscode").load_standalone({ path = "a.code-snippets" })

  -- local cwd = vim.fn.getcwd()
  -- local current_buffer_dir = vim.fn.expand('%:p:h')
  -- log.info("4")

  -- log.info("current_buffer_dir")
  -- log.info(current_buffer_dir)

  local plenary = require('plenary.scandir')
  -- log.info("5")

  local function find_code_snippets()
    local cwd = vim.fn.getcwd()
    -- log.info("6")

    -- log.info("cwd is")
    -- log.info(cwd)

    local files = plenary.scan_dir(cwd .. "/.vscode", {
      depth = 2,
      hidden = true,
    })
    -- log.info("7")
    -- log.info(cwd .. "/.vscode")

    if #files > 0 then
      -- log.info("8")
      -- log.info('Found the following .code-snippets files in the CWD:')
      for _, file in ipairs(files) do
        -- log.info('- ' .. file)

        local text1 = file
        local substring1 = ".code-snippets"
        -- log.info('  text1: ' .. text1)
        -- log.info('  substring1: ' .. substring1)

        -- local ffff = string.find("AAAasdfAAA", "asdf", 0, true)
        -- log.info('ffff: ' .. ffff)

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

    -- log.info("9")
  end

  find_code_snippets()
  -- log.info("10")
end

-- NOTE: Ref: https://neovim.io/doc/user/autocmd#autocmd-events
vim.api.nvim_create_autocmd({ "VimEnter", "BufNewFile", "BufRead", "BufReadPost", "SessionLoadPost" }, { callback = load_snippets_from_workdir })
