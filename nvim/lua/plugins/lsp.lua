return {
    -- 設定 clangd 語言伺服器並指定 /usr/bin/g++ 和 /usr/bin/gcc
    { 
        "neovim/nvim-lspconfig", 
        config = function()
            -- 配置 C/C++ 的 clangd LSP
            require'lspconfig'.clangd.setup{
                cmd = { "clangd", "--compile-commands-dir=.", "--query-driver=/usr/bin/g++,/usr/bin/gcc" }, -- 指定 g++ 和 gcc
                filetypes = { "c", "cpp", "objc", "objcpp" }, -- 支援的檔案類型
                root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
                on_attach = function(client, bufnr)
                    -- 快捷鍵綁定
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local opts = { noremap=true, silent=true }
                    
                    -- 快捷鍵配置
                    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                end,
            }

			-- 配置 GLSL 的 glsl-analyzer LSP
			require'lspconfig'.glsl_analyzer.setup{
				cmd = { "glsl_analyzer" },  -- 因為它已經在 /usr/bin 中，所以不需要指定完整路徑
				filetypes = { "glsl", "vert", "frag", "geom" },  -- 支援的文件類型
				root_dir = require'lspconfig'.util.find_git_ancestor,
				single_file_support = true,
			}

		end
	}
}

