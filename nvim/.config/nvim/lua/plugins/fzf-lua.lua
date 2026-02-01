return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      "default-title",
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          layout = "flex",
          flip_columns = 120,
        },
      },
      files = {
        git_icons = true,
        file_icons = true,
        color_icons = true,
        -- Show hidden files and respect .gitignore
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/'",
        -- Respect .gitignore
        rg_glob = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      buffers = {
        file_icons = true,
        color_icons = true,
      },
      commands = {},
      blines = {},
    })

    -- Setup ui-select replacement
    fzf.register_ui_select()
  end,
}
