return {
    {
        "sidebar-nvim/sidebar.nvim",
        config = function()
            require("sidebar-nvim").setup({
                open = true,  -- 啟動時自動打開側邊欄
                side = "right",  -- 設置側邊欄顯示在右側
                sections = { "diagnostics" },  -- 設置顯示的部分
                update_interval = 1000,  -- 每隔 1000 毫秒（1 秒）更新一次側邊欄
                disable_default_keybindings = true,  -- 禁用默認快捷鍵
                section_separator = "----------------------",  -- 設置每個部分之間的分隔符
                icons = true,  -- 啟用圖示
            })

            -- 自定義快捷鍵來調整側邊欄寬度
            vim.api.nvim_set_keymap("n", "<leader>=", "<cmd>lua require('sidebar-nvim').resize(require('sidebar-nvim').get_width() + 20)<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>-", "<cmd>lua require('sidebar-nvim').resize(require('sidebar-nvim').get_width() - 20)<CR>", { noremap = true, silent = true })

            -- 自定義快捷鍵來切換側邊欄顯示
            vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua require('sidebar-nvim').toggle()<CR>", { noremap = true, silent = true })

            -- 自定義快捷鍵來手動更新側邊欄
            vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>lua require('sidebar-nvim').update()<CR>", { noremap = true, silent = true })
        end
    }
}

