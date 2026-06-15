return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        names = false, -- Disables parsing standard color names like "blue" or "red" (prevents annoying highlights in standard text)
        mode = "background", -- Options: 'foreground', 'background', 'virtualtext'
        tailwind = true, -- Enable tailwind colors
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
      },
    },
  },
}
