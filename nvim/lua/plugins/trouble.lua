return {
    -- 安裝 trouble.nvim 插件
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可選的依賴，為 Trouble 提供圖示支持
        config = function()
            require("trouble").setup {
                -- 配置選項
                icons = {
                    fold_open = "", -- 展開圖示
                    fold_closed = "", -- 折疊圖示
                    error = "", -- 錯誤圖示
                    warning = "", -- 警告圖示
                    hint = "", -- 提示圖示
                    information = "", -- 資訊圖示
                    other = "", -- 其他訊息圖示
                }, -- 圖示配置
                mode = "diagnostics", -- 默認進入 diagnostics 模式
                group = true, -- 將診斷分組
                padding = true, -- 在每行上添加一個額外的空行
                -- 在特定模式下啟用 auto_open
                modes = {
                    --diagnostics = { auto_open = true }, -- 只在 diagnostics 模式下自動打開
                },
                auto_close = true, -- 當沒有診斷時自動關閉 Trouble
                auto_preview = false, -- 啟用自動預覽
            }

            -- 自定義快捷鍵來操作 trouble.nvim

            -- 切換顯示當前緩衝區診斷信息
            vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>", { noremap = true, silent = true })

            -- 設置快捷鍵來將焦點移到 Trouble 窗口
            vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>lua require('trouble').focus()<CR>", { noremap = true, silent = true })

        end
    }
}

