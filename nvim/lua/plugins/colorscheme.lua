return {
    "EdenEast/nightfox.nvim",
    config = function()
        require('nightfox').setup({
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                compile_file_suffix = "_compiled",
                transparent = true,  -- 是否啟用背景透明
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
                    comment = "#FF8800",  -- 設置註釋顏色為橙色
                },
            },
            groups = {
                -- 這裡可以根據需要進行其他高亮組的自定義
            },
        })

        -- 必須在設置後加載主題
        vim.cmd("colorscheme carbonfox")
    end
}

