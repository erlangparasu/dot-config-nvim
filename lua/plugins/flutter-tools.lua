return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = true,
    ft = {
      "dart",
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  }
}

-- require("flutter-tools").setup {} -- use defaults

-- local cmp = require("cmp")
-- cmp.setup {
--   mapping = {
--     ["<C-Space>"] = cmp.mapping.complete(),
--   },
--   sources = {
--     { name = "nvim_lsp" },
--   },
-- }

-- -- Configure additional Dart LSP features
-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...)
--     vim.api.nvim_buf_set_keymap(bufnr, ...)
--   end
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end

--   -- Mappings.
--   local opts = {
--     noremap = true,
--     silent = true
--   }
--   buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
--   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- end

-- require("lspconfig").dartls.setup {
--   on_attach = on_attach
-- }
