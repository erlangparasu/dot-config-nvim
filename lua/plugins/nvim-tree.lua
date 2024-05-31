return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = "*",
        lazy = false,
        build = ':TSUpdate'
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('nvim-tree').setup({
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    show_on_open_dirs = true,
                },
            })
        end,
    }
}
