-- lua/plugins/colorizer.lua
return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy", -- Load the plugin when Neovim is starting up
  config = function()
    require("nvim-highlight-colors").setup({
      --
    })
  end,
}
