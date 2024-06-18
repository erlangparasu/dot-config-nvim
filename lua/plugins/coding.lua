return {
  -- auto completion
  { "golang/vscode-go" },
  { "Neevash/awesome-flutter-snippets" },
  { "stevearc/vim-vscode-snippets" },
  --
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/vim-vsnip-integ" },
  --
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  --
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "nvim_lsp" })
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
      table.insert(opts.sources, { name = "buffer" })
      table.insert(opts.sources, { name = "path" })
      table.insert(opts.sources, { name = "vsnip" })
      table.insert(opts.sources, { name = "nvim_lua" })
    end,
  },
}
