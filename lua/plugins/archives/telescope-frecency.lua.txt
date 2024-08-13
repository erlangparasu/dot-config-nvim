return {
  {
    "nvim-telescope/telescope-frecency.nvim",
    enabled = true,
    config = function()
      require("telescope").load_extension("frecency")
    end,
  }
}
