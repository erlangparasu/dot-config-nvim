return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    config = function()
      require("oil").setup({
        keymaps = {
          ["<Esc>"] = "actions.close"
        },
        delete_to_trash = true,
        lsp_file_methods = {
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 60000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = false,
        },
      })
    end,
    keys = {
      { "<leader>fo", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem (oil)" },
      -- { '-', '<cmd>Oil --float<cr>', mode = 'n', desc = "Open Floating Filesystem" },
    },
  }
}
