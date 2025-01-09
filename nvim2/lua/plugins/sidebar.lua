return {
    {
        "sidebar-nvim/sidebar.nvim",
        config = function()
            local sidebar = require("sidebar-nvim")

            -- 初始化側邊欄設置
            sidebar.setup({
                open = false, -- 默認不打開
                side = "right", -- 設置側邊欄顯示在右側
                sections = { "diagnostics" }, -- 設置顯示的部分
                update_interval = 1000, -- 每隔 1000 毫秒（1 秒）更新一次側邊欄
                disable_default_keybindings = true, -- 禁用默認快捷鍵
                section_separator = "----------------------", -- 設置每個部分之間的分隔符
                icons = true, -- 啟用圖示
            })

            -- 自定義快捷鍵來調整側邊欄寬度
            vim.api.nvim_set_keymap("n", "<leader>=", "<cmd>lua require('sidebar-nvim').resize(require('sidebar-nvim').get_width() + 20)<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>-", "<cmd>lua require('sidebar-nvim').resize(require('sidebar-nvim').get_width() - 20)<CR>", { noremap = true, silent = true })


			-- 定義智能切換側邊欄的函數
            _G.ToggleSidebarWithDiagnosticsCheck = function()
                if sidebar.is_open() then
                    -- 如果側邊欄已打開，則關閉
                    sidebar.close()
                else
                    -- 如果側邊欄未打開，檢查診斷信息
                    local diagnostics = vim.diagnostic.get()
                    if #diagnostics > 0 then
                        sidebar.open()
                    else
                        print("No diagnostics to display")
                    end
                end
            end


			-- 綁定智能切換側邊欄的快捷鍵
            vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua ToggleSidebarWithDiagnosticsCheck()<CR>", { noremap = true, silent = true })


			-- 自動打開或關閉側邊欄的功能
			local function toggle_sidebar_based_on_diagnostics()
				local diagnostics = vim.diagnostic.get()
				if #diagnostics > 0 then
					-- 確保在允許的上下文中執行
					if not sidebar.is_open() then
						vim.schedule(function()
							sidebar.open()
						end)
					end
				else
					if sidebar.is_open() then
						vim.schedule(function()
							sidebar.close()
						end)
					end
				end
			end


            -- 監聽診斷信息變更事件
            vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
                callback = toggle_sidebar_based_on_diagnostics,
            })
        end
    }
}

