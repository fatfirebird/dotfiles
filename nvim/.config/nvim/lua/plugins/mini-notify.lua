return {
  {
    "echasnovski/mini.notify",
    version = false,
    opts = {
      -- Animation style (see below)
      stages = "fade_in_slide_out",
      -- Function to render contents of a notification (see below)
      render = "default",
      -- Time for a notification to live before being removed
      timeout = 3000,
      -- Whether to keep only the last notification
      keep_last = true,
    },
  }
}
