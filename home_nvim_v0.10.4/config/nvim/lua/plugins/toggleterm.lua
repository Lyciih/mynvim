return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup{
                direction = "float", -- 浮動終端
                open_mapping = [[<C-t>]], -- 快捷鍵來打開終端
            }
        end
    }
}

