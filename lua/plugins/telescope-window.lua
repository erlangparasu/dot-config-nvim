return {
  {
    "kyoh86/telescope-windows.nvim",
    enabled = true,
    config = function()
      require("telescope").load_extension('windows')
      -- ":Telescope windows"
    end,
  }
}
