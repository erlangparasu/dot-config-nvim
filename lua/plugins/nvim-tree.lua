return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   version = "*",
  --   lazy = false,
  --   build = ':TSUpdate'
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    version = false,
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        reload_on_bufenter = true,
        respect_buf_cwd = true,
        view = {
          -- File explorer display position, left: left, right: right
          side = "left",
          -- Display line numbers
          number = false,
          relativenumber = false,
          signcolumn = "yes", -- Display icons
          width = 50,
        },
        update_focused_file = {
          enable = true,
          update_root = {
            enable = false,
            ignore_list = {},
          },
          exclude = false,
        },
        git = {
          enable = true,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        actions = {
          change_dir = {
            restrict_above_cwd = true,
          },
        },
      })
    end,
  }
}
