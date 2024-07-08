return {
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end
  }
}
