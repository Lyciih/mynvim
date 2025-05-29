return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",         -- Lua
                    "python",      -- Python
                    "javascript",  -- JavaScript
                    "typescript",  -- TypeScript
                    "c",           -- C
                    "cpp",         -- C++
                    "html",        -- HTML
                    "css",         -- CSS
                    "php",         -- PHP
                    "glsl",         -- GLSL
					"bash"
                },
                sync_install = false,  -- 同步安装（设置为 true 会一次性下载所有语言）
                auto_install = true,  -- 自动安装缺失的解析器
                highlight = {
                    enable = true,   -- 启用高亮
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,   -- 启用智能缩进
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
				},
				refactor = {
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = "<leader>trn", -- Treesitter 重命名
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}

