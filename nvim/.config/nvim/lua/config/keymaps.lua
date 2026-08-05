-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Delete whichever mark is set on the current line
vim.keymap.set("n", "dm", function()
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local deleted = false

  for i = 1, #marks do
    local m = marks:sub(i, i)
    local pos = vim.api.nvim_buf_get_mark(0, m)
    if pos[1] == cur_line then
      vim.cmd("delmarks " .. m)
      vim.notify("Deleted mark '" .. m .. "' on line " .. cur_line, vim.log.levels.INFO)
      deleted = true
    end
  end

  if not deleted then
    vim.notify("No mark found on current line", vim.log.levels.WARN)
  end
end, { desc = "Delete mark on current line" })
