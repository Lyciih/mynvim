require("config.lazy")

-- 設置縮排為 4 個空格
vim.o.tabstop = 4        -- 設置 Tab 字符的寬度為 4
vim.o.shiftwidth = 4     -- 設置自動縮排的寬度為 4
vim.o.softtabstop = 4    -- 設置編輯模式下 Tab 的顯示寬度為 4
-- vim.o.expandtab = true   -- 使用空格代替 Tab


-- 啟用光標行和光標列
vim.opt.cursorline = true
vim.opt.cursorcolumn = true


-- 設置快捷鍵 <leader>n 聚焦到 NvimTree 窗口
vim.keymap.set("n", "<leader>t", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus NvimTree" })



vim.opt.number = true           -- 顯示當前行的行號
vim.opt.relativenumber = true   -- 顯示相對行號

