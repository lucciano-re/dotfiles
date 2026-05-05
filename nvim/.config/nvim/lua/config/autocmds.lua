-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Inside the keymap function:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" }, -- Target both C and C++ files
  callback = function()
    vim.keymap.set("n", "<leader>cr", function()
      -- 1. Save the current file
      vim.cmd("write")

      -- 2. Get file paths and escape them for the shell
      local file = vim.fn.shellescape(vim.fn.expand("%:p"))
      local out = vim.fn.shellescape(vim.fn.expand("%:p:r") .. ".out")

      -- 3. Dynamically choose the compiler based on the filetype
      local compiler = vim.bo.filetype == "cpp" and "g++" or "gcc"
      local lang_name = vim.bo.filetype == "cpp" and "C++" or "C"

      -- 4. Define compile and run commands
      local compile_cmd = string.format("%s %s -o %s", compiler, file, out)
      local run_cmd = out

      -- 5. Create a scratch buffer for the terminal
      local buf = vim.api.nvim_create_buf(false, true)

      -- 6. Calculate floating window size and position (80% of screen)
      local ui = vim.api.nvim_list_uis()[1]
      local width = math.floor(ui.width * 0.8)
      local height = math.floor(ui.height * 0.8)
      local col = math.floor((ui.width - width) / 2)
      local row = math.floor((ui.height - height) / 2)

      -- 7. Open the floating window dynamically titled
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = string.format(" %s Compiler & Runner ", lang_name),
        title_pos = "center",
      })

      -- 8. Execute in terminal: compile, run, and wait for Enter to close
      local full_cmd = string.format("%s && %s ; echo ''; echo 'Press <Enter> to close.'; read", compile_cmd, run_cmd)

      vim.fn.termopen(full_cmd, {
        on_exit = function()
          -- Map Enter to close the window easily once the program finishes
          vim.keymap.set("n", "<CR>", "<cmd>bd!<CR>", { buffer = buf })
        end
      })

      -- 9. Enter insert mode automatically
      vim.cmd("startinsert")
    end, { desc = "Compile and Run C/C++ in Float", buffer = true })
  end,
})
