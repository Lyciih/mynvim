return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- 可選，提供文件類型圖示
        },
        config = function()
            require('nvim-tree').setup {
                view = {
                    width = 30,  -- 文件樹的寬度
                    side = 'left',  -- 文件樹顯示的位置
                },
                renderer = {
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                        },
                    },
                },
            }

            -- 打開/關閉 nvim-tree 的快捷鍵
            vim.api.nvim_set_keymap(
                'n',
                '<leader>e',
                ':NvimTreeToggle<CR>',
                { noremap = true, silent = true }
            )

            -- 設置焦點切換的快捷鍵
            vim.api.nvim_set_keymap(
                'n',
                '<leader>fe',
                ':lua ToggleNvimTreeFocus()<CR>',
                { noremap = true, silent = true }
            )

            -- 定義一個 Lua 函數來切換焦點
            function ToggleNvimTreeFocus()
                local api = require('nvim-tree.api')
                if vim.bo.filetype == "NvimTree" then
                    -- 如果焦點在 NvimTree 窗口，切換回上一個窗口
                    vim.cmd('wincmd p')
                else
                    -- 如果焦點不在 NvimTree，切換焦點到 NvimTree
                    api.tree.focus()
                end
            end
        end
    }
}
