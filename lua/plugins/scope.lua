return {
  {
    "tiagovla/scope.nvim",
    enabled = true,
    opts = {},
    config = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end
  }
}
