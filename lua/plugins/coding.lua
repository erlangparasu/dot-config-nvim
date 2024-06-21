return {
  {
    "hrsh7th/vim-vsnip",
  },
  {
    "hrsh7th/vim-vsnip-integ",
  },
  {
    "hrsh7th/cmp-vsnip",
  },

  -- Add vsnip source to cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "vsnip" })
    end,
  },
}
