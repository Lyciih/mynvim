return {
	-- 安裝 lualine
	"nvim-lualine/lualine.nvim",
	dependencies = { 'kyazdani42/nvim-web-devicons' },  -- 顯示圖標
	config = function()
		require('lualine').setup({
			options = {
				Cons_enabled = true,
				theme = 'papercolor_dark',  -- 設置 lualine 使用 nightfox 主題

				nent_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},

			},
			sections = {
				-- 可以根據需要自定義 lualine 的顯示區塊
				lualine_b = {'branch'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			}
		})
	end
}
