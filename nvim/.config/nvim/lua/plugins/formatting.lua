return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", lsp_format = "fallback" },
        typescript = { "prettier", lsp_format = "fallback" },
        javascriptreact = { "prettier", lsp_format = "fallback" },
        typescriptreact = { "prettier", lsp_format = "fallback" },
        svelte = { "prettier", lsp_format = "fallback" },
        css = { "prettier", "stylelint" },
        scss = { "stylelint" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
      },
      format_after_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
        -- async = false,
      },
      formatters = {
        prettier = {
          condition = function(_self, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.json5",
              ".prettierrc.js",
              ".prettierrc.cjs",
              ".prettierrc.mjs",
              ".prettierrc.toml",
              "prettier.config.js",
              "prettier.config.cjs",
              "prettier.config.mjs",
            }, { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
        stylelint = {
          command = "stylelint",
          args = {
            "--fix",
            "--stdin",
            "--stdin-filename",
            "$FILENAME",
          },
          stdin = true,
          exit_codes = { 0, 1, 2 },
          cwd = require("conform.util").root_file({
            "stylelint.config.js",
            ".stylelintrc.json",
            ".stylelintrc.js",
            "package.json",
          }),
        },
      },
    })
  end,
}
