return {
  {
    "tiagovla/scope.nvim",
    enabled = false,
    opts = {},
    config = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end
  }
}
