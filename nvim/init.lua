require("config.lazy")


-- 設置縮排為 4 個空格
vim.o.tabstop = 4        -- 設置 Tab 字符的寬度為 4
vim.o.shiftwidth = 4     -- 設置自動縮排的寬度為 4
vim.o.softtabstop = 4    -- 設置編輯模式下 Tab 的顯示寬度為 4
-- vim.o.expandtab = true   -- 使用空格代替 Tab
--
--
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END
]])


-- 自動將 .vert, .frag, .glsl 文件設置為 glsl 文件類型
vim.cmd [[
  autocmd BufRead,BufNewFile *.vert,*.frag,*.glsl set filetype=glsl
]]



-- 啟用光標行和光標列
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- 啟用增量搜尋
set incsearch


