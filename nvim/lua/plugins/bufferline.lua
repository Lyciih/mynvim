return {
	-- 安裝 bufferline.nvim 插件
	{
		'akinsho/bufferline.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }, -- 如果你想要圖標支持
		config = function()
			require("bufferline").setup{
				options = {
					numbers = "none", -- 不顯示緩衝區編號
					diagnostics = "nvim_lsp", -- 使用 LSP 的診斷信息
					separator_style = "slant", -- 緩衝區之間的分隔樣式
					show_buffer_close_icons = true, -- 顯示關閉按鈕
					show_close_icon = false, -- 隱藏整體關閉按鈕
					show_tab_indicators = true, -- 顯示標籤指示符
					always_show_bufferline = false, -- 總是顯示 bufferline，即使只有一個 buffer
					indicator = {
						icon = '', -- 不需要圖標
						style = 'underline', -- 使用下劃線作為指示器樣式
					},
					offsets = {
						{
							filetype = "NvimTree",  -- 偏移 NvimTree（在左側）
							text = "File Explorer",
							text_align = "left",
							separator = true
						}
					},
				},
			}

			-- 切換到下一個緩衝區
			vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

			-- 切換到上一個緩衝區
			vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })

			-- 關閉當前緩衝區
			vim.api.nvim_set_keymap('n', '<leader>c', ':Bdelete<CR>', { noremap = true, silent = true })

		end
	}
}

