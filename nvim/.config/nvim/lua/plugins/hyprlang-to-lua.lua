return {
  "pynappo/hyprlang-to-lua.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  -- Load it lazily on hyprlang files
  ft = "hyprlang",
}
