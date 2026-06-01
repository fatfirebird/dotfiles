return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
  config = function()
    require('render-markdown').setup({
      completions = {
        lsp = { enabled = true },
        coq = { enabled = true }
      },
      heading = {
        border = true,
        border_virtual = true,
        backgrounds = {
          'RenderMarkdownH6Bg',
          'RenderMarkdownH6Bg',
          'RenderMarkdownH6Bg',
          'RenderMarkdownH6Bg',
          'RenderMarkdownH6Bg',
          'RenderMarkdownH6Bg',
        },
        foregrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        },
        icons = { '󰼏  ' }
      },
      -- anti_conceal = { enabled = false },
      render_modes = true
    })
  end,
}
