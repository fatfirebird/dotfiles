return {
  "3rd/image.nvim",
  build = false,
  opts = {
    processor = "magick_cli",
    tmux_show_only_in_active_window = true,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        only_render_image_at_cursor = false,
        resolve_image_path = function(document_path, image_path, fallback)
          local vault_root = vim.fn.expand("~/Documents/Obsidian Vault")
          if vim.startswith(document_path, vault_root) then
            local candidate = vault_root .. "/" .. image_path
            if vim.fn.filereadable(candidate) == 1 then
              return candidate
            end
          end
          return fallback(document_path, image_path)
        end,
      },
    },
  },
}
