return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} }, { "benomahony/oil-git.nvim", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require("oil").setup({
        float = {
          padding = 4,
        },
        watch_for_changes = true,
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
