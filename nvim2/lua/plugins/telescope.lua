return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set("n", '<leader>fd', builtin.lsp_definitions, { noremap = true, silent = true })


            require('telescope').setup({
                defaults = {
                    -- 調整外框樣式
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    borderchars = {
                        prompt = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
                        results = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
                        preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
                    },
                    winblend = 0, -- 設置透明度
                },
            })

            -- 自訂 Telescope 高亮群組的顏色
            -- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#ffffff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#ffffff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#ffffff", bg = "NONE" })
            vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#ffffff", bg = "NONE" })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#ffaa00", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#00ffaa", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#aa00ff", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = "#ffaa00", bg = "NONE", bold = true })
        end,
    },
	{
        "nvim-telescope/telescope-live-grep-args.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end,
		keys = { { "<leader>fa", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "Live Grep with Args" } },
    },
}

