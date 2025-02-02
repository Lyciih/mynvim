require("config.lazy")



require("luasnip").config.setup({
    enable_jsregexp = true,
})


-- 設置縮排為 4 個空格
vim.o.tabstop = 4        -- 設置 Tab 字符的寬度為 4
vim.o.shiftwidth = 4     -- 設置自動縮排的寬度為 4
vim.o.softtabstop = 4    -- 設置編輯模式下 Tab 的顯示寬度為 4
-- vim.o.expandtab = true   -- 使用空格代替 Tab


-- 啟用光標行和光標列
vim.opt.cursorline = true
vim.opt.cursorcolumn = true



-- 啟動時先打開相對行號
vim.opt.number = true           -- 顯示當前行的行號
vim.opt.relativenumber = true   -- 顯示相對行號


-- 定義切換行號模式的函數
local function toggle_number()
    if vim.o.number and vim.o.relativenumber then
        vim.o.number = false
        vim.o.relativenumber = false
    elseif vim.o.number then
        vim.o.relativenumber = true
    else
        vim.o.number = true
    end
end

-- 映射領導鍵 + n 來執行切換
vim.keymap.set("n", "<leader>n", toggle_number, { noremap = true, silent = true })



-- 在診斷訊息之間移動
vim.keymap.set('n', '<leader>g', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>b', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })


-- 使用 split/vsplit 打开当前缓冲区
vim.api.nvim_set_keymap('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })


