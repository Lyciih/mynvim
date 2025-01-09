return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup()
    end,
    keys = { { "<leader>r", ":IncRename <C-R><C-W>", desc = "Incremental Rename" } },
}

