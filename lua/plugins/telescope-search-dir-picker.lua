return {
  {
    "smilovanovic/telescope-search-dir-picker.nvim",
    enabled = true,
    config = function()
      require("telescope").load_extension("search_dir_picker")
    end,
  }
}
