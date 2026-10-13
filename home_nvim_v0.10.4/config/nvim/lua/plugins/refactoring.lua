return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("refactoring").setup({})
        end,
        keys = {
            -- 插入調試信息
            { "<leader>rd", ":lua require('refactoring').debug.print_var({})<CR>", desc = "Debug Print Variable" },
            -- 清理調試信息
            { "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", desc = "Cleanup Debug Prints" },
        },
    },
}

