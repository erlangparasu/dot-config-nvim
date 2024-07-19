return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   version = "*",
  --   lazy = false,
  --   build = ':TSUpdate'
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    version = false,
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('nvim-tree').setup({
        view = {
          -- File explorer display position, left: left, right: right
          side = "left",
          -- Display line numbers
          number = false,
          relativenumber = false,
          signcolumn = "yes", -- Display icons
          width = 60,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        update_focused_file = {
          enable = true,
          update_root = {
            enable = true,
            ignore_list = {},
          },
          exclude = false,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
      })
    end,
  }
}
