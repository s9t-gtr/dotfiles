-- クリップボード設定
vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth=4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.hidden = true
vim.o.autoread = true
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.bufexists(0) == 1 then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
})

