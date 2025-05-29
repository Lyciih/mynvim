
return {
	{
		"preservim/vim-pencil",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.g["pencil#conceallevel"] = 2         -- 美化顯示符號
			vim.g["pencil#wrapModeDefault"] = "soft" -- soft wrap 模式
			vim.g["pencil#textwidth"] = 80           -- 預設換行寬度

			vim.cmd([[
	  augroup Pencil
	  autocmd!
	  autocmd FileType markdown,text,tex call pencil#init()
	  augroup END
	  ]])
		end
	},


	{
		'ivanesmantovich/xkbswitch.nvim',
		config = function()
			require('xkbswitch').setup()
		end,
	}
}




 -- return {
 --   {
 --     "lukas-reineke/headlines.nvim",
 --     dependencies = {
 --       "nvim-treesitter/nvim-treesitter"
 --     },
 --     ft = { "markdown", "norg", "org" }, -- 可依需要擴充
 --     config = function()
 --       require("headlines").setup {
 --         markdown = {
 --           headline_highlights = {
 --             "Headline1",
 --             "Headline2",
 --             "Headline3",
 --             "Headline4",
 --             "Headline5",
 --             "Headline6",
 --           },
 --           bullets = { "◉", "○", "✸", "✿" },
 --           codeblock_highlight = "CodeBlock",
 --         }
 --       }
 -- 
 --       -- 可選：定義色彩風格
 --       vim.cmd [[
 -- 		highlight Headline1 guibg=#5f0000 guifg=#ffffff
 --         highlight Headline2 guibg=#005f5f guifg=#ffffff
 --         highlight Headline3 guibg=#875f00 guifg=#ffffff
 --         highlight Headline4 guibg=#5f0087 guifg=#ffffff
 --         highlight Headline5 guibg=#005f87 guifg=#ffffff
 --         highlight Headline6 guibg=#444444 guifg=#ffffff
 --         highlight CodeBlock guibg=#1c1c1c guifg=#cccccc
 --       ]]
 --     end
 --   }
 -- }
 -- 
