return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "bash",
        "regex",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      auto_install = true,
      ignore_install = {},
    })
  end,
}
