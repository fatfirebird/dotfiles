return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "css_variables",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("biome")

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
        callback = function()
          vim.lsp.buf.code_action({
            context = { only = { "source.fixAll.eslint" } },
            apply = true,
          })
        end,
      })
    end,
  },
}
