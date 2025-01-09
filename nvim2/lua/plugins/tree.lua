return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- 停用 netrw，避免衝突
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- 啟用 24 位元色彩
		vim.opt.termguicolors = true



		local function my_on_attach(bufnr)
			local api = require "nvim-tree.api"

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))   -- 上一層目錄
			vim.keymap.set('n', '<C-d>', api.tree.change_root_to_node,   opts('Down')) -- 進入子目錄
			vim.keymap.set('n', '?',     api.tree.toggle_help,          opts('Help'))

			-- vim.keymap.set('n', '<leader>r', '<C-w>l', opts('Focus Right Window'))


		end

		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })


		require("nvim-tree").setup({
			on_attach = my_on_attach, -- 在tree中使用自訂鍵盤映射
			sort = {
				sorter = "case_sensitive", -- 大小寫敏感排序
			},
			view = {
				adaptive_size = true, -- 自動調整檔案樹寬度
				-- width = 30, -- 檔案樹寬度
				number = false,          -- 啟用絕對行號
				relativenumber = true,  -- 啟用相對行號
			},
			renderer = {
				group_empty = true, -- 將空目錄分組
			},
			filters = {
				-- dotfiles = true, -- 過濾隱藏檔案
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false, -- 禁用窗口选择器，直接在当前窗口打开文件
					},
				},
			},
		})


		-- 修改分隔線顏色
		vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#ffffff", bg = "NONE", bold = true })

	end,
}
