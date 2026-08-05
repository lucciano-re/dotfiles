-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.indent = opts.indent or {}
    opts.indent.disable = opts.indent.disable or {}
    table.insert(opts.indent.disable, "c")
  end,
}

