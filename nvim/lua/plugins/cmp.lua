return {
    -- nvim-cmp 和相關插件
    {
        "hrsh7th/nvim-cmp",  -- 自動補全插件核心
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",  -- LSP 支持
            "hrsh7th/cmp-buffer",    -- 緩衝區中的文本補全
            "hrsh7th/cmp-path",      -- 文件路徑補全
            "hrsh7th/cmp-cmdline",   -- 命令行補全
            "saadparwaiz1/cmp_luasnip", -- LuaSnip 支持
            "L3MON4D3/LuaSnip",      -- 片段補全引擎
        },
        config = function()
            -- 配置 nvim-cmp
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- 配置片段引擎
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- 確認選中的補全項
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },   -- 從 LSP 取得補全建議
                    { name = 'luasnip' },    -- 支持 LuaSnip 片段
                }, {
                    { name = 'buffer' },     -- 緩衝區中的文本補全
                    { name = 'path' },       -- 文件路徑補全
                })
            })

            -- 設置命令行補全
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            -- 設置搜索補全
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    },
    -- LSP 配置
    {
        "neovim/nvim-lspconfig",  -- LSP 客戶端配置
        config = function()
            local lspconfig = require('lspconfig')

            -- 配置某些 LSP 伺服器（以 clangd 為例）
            lspconfig.clangd.setup{}
            -- 你可以為其他語言設置更多的 LSP 伺服器
        end
    }
}

