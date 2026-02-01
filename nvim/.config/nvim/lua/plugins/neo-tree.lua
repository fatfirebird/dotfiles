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
      components = {
        harpoon_index = function(config, node, _)
          local harpoon_list = require("harpoon"):list()
          local path = node:get_id()
          local harpoon_key = vim.uv.cwd()

          for i, item in ipairs(harpoon_list.items) do
            local value = item.value
            if string.sub(item.value, 1, 1) ~= "/" then
              value = harpoon_key .. "/" .. item.value
            end

            if value == path then
              vim.print(path)
              return {
                text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            end
          end
          return {}
        end,
      },

      renderers = {
        file = {
          { "icon" },
          { "name", use_git_status_colors = true },
          { "harpoon_index" }, --> This is what actually adds the component in where you want it
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
