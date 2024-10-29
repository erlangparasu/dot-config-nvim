return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    config = function()
      require("oil").setup({
        keymaps = {
          ["<Esc>"] = "actions.close",
          ["`"] = function()
            -- NOTE:cwd (current working directory)
            local old_dir = vim.fn.getcwd()

            -- NOTE: cd to selected directory by oil
            require("oil.actions").cd.callback()

            local cwd = vim.fn.getcwd()
            if cwd == old_dir then
              -- see: autoload_session
              vim.cmd("LoadSession")
            else
              -- see: switch_session
              vim.cmd("SwitchSession " .. cwd)
            end
          end
        },
        delete_to_trash = true,
        lsp_file_methods = {
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 60000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = false,
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return false
          end,
          -- Sort file names in a more intuitive order for humans. Is less performant,
          -- so you may want to set to false if you work with large directories.
          natural_order = true,
          -- Sort file and directory names case insensitive
          case_insensitive = false,
          sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
          },
        },
      })
    end,
    keys = {
      { "<leader>fo", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem (oil)" },
      -- { '-', '<cmd>Oil --float<cr>', mode = 'n', desc = "Open Floating Filesystem" },
    },
  }
}
