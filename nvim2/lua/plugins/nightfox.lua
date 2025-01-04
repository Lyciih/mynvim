return {
    "EdenEast/nightfox.nvim",
    config = function()
        require('nightfox').setup({
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                compile_file_suffix = "_compiled",
                transparent = false,  -- 是否啟用背景透明
                terminal_colors = true,
                dim_inactive = false,
                module_default = true,
                styles = {
                    comments = "italic",  -- 設置註釋為斜體
                },
                inverse = {
                    match_paren = false,
                    visual = false,
                    search = false,
                },
            },
            palettes = {
                -- 自定義主題的調色板
                carbonfox = {
                    -- 你可以在這裡自定義其他顏色
                    -- comment = "#FF8800",  -- 設置註釋顏色為橙色
                },
            },
			groups = {
				-- 這裡可以根據需要進行其他高亮組的自定義
				all = {
					Comment = { fg = "#FF8800", bg = "NONE" }, -- 註釋顏色
					Search = { bg = "#3ddbd9", fg = "#000000" }, -- 所有搜尋匹配
                    IncSearch = { bg = "#FFD700", fg = "#000000" }, -- 當前匹配項
					Visual = { bg = "#005f87", fg = "#ffffff" }, -- 選取文字時的顏色
					CursorLine = { bg = "#505050" }, -- 光標所在行的背景顏色
                    CursorColumn = { bg = "#505050" }, -- 光標所在列的背景顏色
				},
			},
        })

        -- 必須在設置後加載主題
        vim.cmd("colorscheme terafox")
    end
}

