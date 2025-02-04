return {
	-- 1. Mason 插件：負責安裝和管理 LSP
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	-- 2. Mason 與 LSP 配置的整合
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls", -- 使用 ts_ls
					"clangd",
					"html",
					"cssls",
					"intelephense",
					-- glsl 的 lsp 改用手動安裝的 glslls
					-- https://github.com/svenstaro/glsl-language-server
					-- lspconfig 設定方式 https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#glslls 
					"bashls",
				},
			})
		end,
	},
	-- 3. 函數簽名提示插件
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				hint_enable = false,
				floating_window = true,
				max_width = 200, -- 設置最大寬度為 80 字元
				handler_opts = {
					border = "rounded",
				},
				hi_parameter = "Search", -- 為函數參數設置特殊高亮
			})

			-- 設置浮動窗口背景顏色
			--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#ffffff", fg = "#ffffff" }) -- 浮動窗口背景和字體顏色
			--vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#ffffff", fg = "#ffffff" }) -- 浮動窗口邊框顏色

		end,
	},
	-- 4. 配置 LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"ray-x/lsp_signature.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				require("lsp_signature").on_attach({}, bufnr)
			end

			-- 配置 Lua LSP
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- 配置 Python LSP
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- 配置 JavaScript/TypeScript LSP
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
				on_attach = on_attach,
			})

			-- 配置 C/C++ LSP
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--compile-commands-dir=.",
					"--query-driver=/usr/bin/g++,/usr/bin/gcc",
					-- "--ignore-unknown-flags"
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git", "CMakeLists.txt"),
				capabilities = capabilities,
				on_attach = on_attach,
			})



			-- 配置 GLSL LSP
			require('lspconfig').glslls.setup({
				cmd = { "glslls", "--stdin" }, -- 使用官方推薦的啟動方式
				capabilities = {
					offsetEncoding = { "utf-8", "utf-16" },
					textDocument = {
						completion = {
							editsNearCursor = true
						}
					}
				},
				filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
				single_file_support = true,
			})



			-- 配置 HTML LSP
			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- 配置 CSS LSP
			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- 配置 PHP LSP
			lspconfig.intelephense.setup({
				capabilities = capabilities,
				settings = {
					intelephense = {
						files = {
							maxSize = 10000000,
						},
					},
				},
				on_attach = on_attach,
			})
		end,
	},
	-- 5. 配置補全引擎
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
						{ name = "cmdline" },
					}),
			})
		end,
	},
	-- 6. lsp lines
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			-- 禁用默認虛擬文本，以避免與 lsp_lines 冲突
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
}

