return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8', -- 版本標籤
		dependencies = { 'nvim-lua/plenary.nvim' }, -- 依賴項

		config = function()
			-- 載入 Telescope 的內建函數
			local builtin = require('telescope.builtin')

			-- 設置快捷鍵
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			--vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			--vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		end,
	},

	-- 安裝文件瀏覽擴展
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup {
				extensions = {
					file_browser = {
						theme = "ivy", -- 可選：設置文件瀏覽的主題風格
						hijack_netrw = true, -- 可選：取代 netrw
					},
				},
			}
			-- 加載 Telescope 的文件瀏覽擴展
			require("telescope").load_extension "file_browser"


			-- 快捷鍵綁定
			vim.api.nvim_set_keymap(
			'n',
			'<leader>fb',
			':Telescope file_browser<CR>',
			{ noremap = true, silent = true }
			)
		end
	}
}

