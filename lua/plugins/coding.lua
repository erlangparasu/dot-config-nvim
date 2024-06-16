return {
  -- auto completion
  {
    "golang/vscode-go",
  },
  {
    "hrsh7th/vim-vsnip",
  },
  {
    "hrsh7th/vim-vsnip-integ",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "vsnip", group_index = 0 })
    end,
  },
}