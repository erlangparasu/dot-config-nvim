return {
  {
    "antosha417/nvim-lsp-file-operations",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-tree.lua",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup {
        -- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
        debug = false,
        -- select which file operations to enable
        operations = {
          willRenameFiles = true,
          didRenameFiles = true,
          willCreateFiles = true,
          didCreateFiles = true,
          willDeleteFiles = true,
          didDeleteFiles = true,
        },
        -- how long to wait (in milliseconds) for file rename information before cancelling
        timeout_ms = 60000,
      }
    end,
  },
}
