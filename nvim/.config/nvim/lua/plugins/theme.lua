return {
  "sainnhe/gruvbox-material",
  name = "gruvbox",
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_enable_italic = false
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.cmd.colorscheme("gruvbox-material")
    vim.cmd([[
      highlight NeoTreeNormal guibg=NONE
      highlight NeoTreeNormalNC guibg=NONE
      highlight NeoTreeEndOfBuffer guibg=NONE
    ]])
  end,
}
