return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = true,
  cmd = "Neotree",
  opts = {
    default_component_configs = {
      name = {
        use_git_status_colors = false,
      },
    },
    clipboard = {
      sync = "universal",
    },
    buffers = {
      leave_dirs_open = true,
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["o"] = "system_open",
        },
      },
      filtered_items = {
        visible = true,
      },
      renderers = {
        file = {
          { "icon" },
          { "name",       use_git_status_colors = true },
          { "diagnostics" },
          { "git_status", highlight = "NeoTreeDimText" },
        },
      },
    },

    source_selector = {
      winbar = false,
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        -- vim.fn.jobstart({ "open", path }, { detach = true })
        -- Linux: open file in default application
        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      end,
    },
  },
}
