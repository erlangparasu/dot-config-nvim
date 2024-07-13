return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      -- local a = vim.api
      -- local tel_actions = require("telescope.actions")
      -- local tel_config = require("telescope.config")

      local actions = require("telescope.actions")

      --  ["<C-u>"] = actions.preview_scrolling_up,
      --  ["<C-d>"] = actions.preview_scrolling_down,
      --  ["<C-f>"] = actions.preview_scrolling_left,
      --  ["<C-k>"] = actions.preview_scrolling_right,
      --
      --  ["<PageUp>"] = actions.results_scrolling_up,
      --  ["<PageDown>"] = actions.results_scrolling_down,
      --  ["<M-f>"] = actions.results_scrolling_left,
      --  ["<M-k>"] = actions.results_scrolling_right,

      -- map("i", "<M-S-Left>", My_results_scrolling_left, { noremap = true, silent = true, desc = "Scroll left -Telescope results" })
      -- map("i", "<M-S-Right>", My_results_scrolling_right, { noremap = true, silent = true, desc = "Scroll right -Telescope results" })

      -- table.insert(opts.defaults.mappings.i, { "<M-S-Left>" = actions.results_scrolling_left});

      opts.defaults.mappings.i["<M-S-Left>"] = actions.results_scrolling_left;
      opts.defaults.mappings.i["<M-S-Right>"] = actions.results_scrolling_right;
      opts.defaults.mappings.i["<M-S-Up>"] = actions.results_scrolling_up;
      opts.defaults.mappings.i["<M-S-Down>"] = actions.results_scrolling_down;

      return opts;
    end,
  }
}
