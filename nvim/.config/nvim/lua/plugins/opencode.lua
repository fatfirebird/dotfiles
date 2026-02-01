return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {

      enabled = "native",
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Claude-style keymaps under <leader>a
    vim.keymap.set({ "n", "t" }, "<leader>ac", function()
      require("opencode").toggle()
    end, { desc = "Toggle OpenCode" })
    vim.keymap.set({ "n", "x" }, "<leader>as", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Send to OpenCode" })
    vim.keymap.set({ "n", "x" }, "<leader>aa", function()
      require("opencode").select()
    end, { desc = "Execute action" })
    vim.keymap.set("n", "<leader>am", function()
      require("opencode").command("session.select.model")
    end, { desc = "Select model" })


    -- Operator mode for adding ranges
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    -- Scrolling
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })
  end,
}
