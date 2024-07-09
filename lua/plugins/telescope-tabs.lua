return {
  {
    "LukasPietzschmann/telescope-tabs",
    enabled = true,
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require('telescope').load_extension('telescope-tabs')
      require('telescope-tabs').setup()
    end,
  }
}
