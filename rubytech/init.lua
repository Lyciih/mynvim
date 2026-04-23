
--[[
-- use clipboard osc52 when ssh (nvim install in server) --------------------------
vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = function(lines, _)
      require("vim.ui.clipboard.osc52").copy("+")(lines)
    end,
    ["*"] = function(lines, _)
      require("vim.ui.clipboard.osc52").copy("*")(lines)
    end,
  },
  paste = {
    ["+"] = function() return {} end,
    ["*"] = function() return {} end,
  },
}
]]

-- hover present time -------------------------------------------------------------
vim.o.updatetime = 300

-- tab ----------------------------------------------------------------------------
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = false

-- cursor line & column -----------------------------------------------------------
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#404040" })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#505050" })

-- line number --------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true

-- line number mode change function
local function toggle_number()
    if vim.o.number and vim.o.relativenumber then
        vim.o.number = false
        vim.o.relativenumber = false
    elseif vim.o.number then
        vim.o.relativenumber = true
    else
        vim.o.number = true
    end
end


-- close --------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

-- plugin install -----------------------------------------------------------------
vim.pack.add({
	-- nvim-treesitter
	'https://github.com/nvim-treesitter/nvim-treesitter',
	-- telescope
	'https://github.com/nvim-lua/plenary.nvim',	-- dependencies
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	-- toggleterm
	'https://github.com/akinsho/toggleterm.nvim',
	-- nvim-tree
	'https://github.com/nvim-tree/nvim-tree.lua',
	-- lualine
	'https://github.com/nvim-lualine/lualine.nvim',
	-- mason
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	-- lsp_signature
	'https://github.com/ray-x/lsp_signature.nvim',

	-- nvim-cmp
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	'https://github.com/hrsh7th/cmp-buffer',
	'https://github.com/hrsh7th/cmp-path',
	'https://github.com/hrsh7th/cmp-cmdline',
	'https://github.com/hrsh7th/cmp-vsnip',
	'https://github.com/hrsh7th/vim-vsnip',
	'https://github.com/onsails/lspkind.nvim',

	-- nvim-lspconfig
	'https://github.com/neovim/nvim-lspconfig',

	-- trouble
	'https://github.com/folke/trouble.nvim',
})


-- plugin load --------------------------------------------------------------------

-- nvim-treesitter
require('nvim-treesitter').setup {
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install({
	'c',
	'cpp',
	'bash',
	'glsl',
	'html',
	'javascript',
	'css'
}):wait(300000) -- wait max. 5 minutes


-- telescope
require('telescope').setup({
	extensions = {
		fzf = {}
	}
})
require('telescope').load_extension('fzf')

-- toggleterm
require('toggleterm').setup({
	direction = "float",
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
	vim.keymap.set('n', '<C-d>', api.tree.change_root_to_node,   opts('Down'))
	vim.keymap.set('n', '?',     api.tree.toggle_help,          opts('Help'))
end
require('nvim-tree').setup({
	on_attach = my_on_attach,
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		adaptive_size = true,
		-- width = 30,
		number = false,
		relativenumber = true,
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#ffffff", bg = "NONE", bold = true })

-- lualine
require('lualine').setup({
	options = {
		Cons_enabled = true,
		nent_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
	},
	sections = {
		lualine_b = {'branch'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {
			{
				'progress',
				color = { bg = '#f4a261', fg = '#000000' },
			}
		},
		lualine_z = {'location'}
	}
})

-- mason
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"clangd",
	},
})

-- lsp
require('lsp_signature').setup({
	bind = true,
	hint_enable = false,
	floating_window = true,
	max_width = 200,
	handler_opts = {
		border = "rounded",
	},
	hi_parameter = "Search",
})

-- lspkind
require('lspkind').setup({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    },
})

-- cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

			-- For `mini.snippets` users:
			-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			-- insert({ body = args.body }) -- Insert at cursor
			-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			-- require("cmp.config").set_onetime({ sources = {} })
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
		{ name = "path" },
	}),
	formatting = {
		fields = { 'abbr', 'icon', 'kind', 'menu' },
		format = lspkind.cmp_format({
			maxwidth = {
				-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				-- can also be a function to dynamically calculate max width such as
				-- menu = function() return math.floor(0.45 * vim.o.columns) end,
				menu = 50, -- leading text (labelDetails)
				abbr = 50, -- actual suggestion item
			},
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			show_labelDetails = true, -- show labelDetails in menu. Disabled by default

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function (entry, vim_item)
				-- ...
				return vim_item
			end
		})
	}
})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})



-- trouble
require('trouble').setup({
	opt = {},
	cmd = "Trouble",
	--[[
	preview = {
    type = "float",
    relative = "editor",
    border = "rounded",
    title = "Preview",
    title_pos = "center",
    position = { 0.3, 0.5 }, -- (row, col)
    size = { width = 0.4, height = 0.4 },
    zindex = 200,
	]]
	preview = {
    type = "split",
    relative = "win",
    position = "right",
    size = 0.3,
  },
})


-- lsp config ---------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach({}, bufnr)
end
vim.lsp.config('clangd', {
	cmd = { "clangd", "--background-index" },
	root_markers = { "compile_commands.json", ".git", "CMakeLists.txt" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- lsp enable ---------------------------------------------------------------------
vim.lsp.enable('clangd')

-- diagnostic ---------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- hover diagnostic
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focus = false,
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		})
	end
})

-- hover color
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#f4a261" })



-- key map begin ------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.timeout = true
vim.opt.timeoutlen = 2000

vim.keymap.set('n', '<leader>sh', ':split<CR>')
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<leader>sc', ':close<CR>')
vim.keymap.set('n', '<C-Up>', '<C-w>+')
vim.keymap.set('n', '<C-Down>', '<C-w>-')
vim.keymap.set('n', '<C-Left>', '<C-w><')
vim.keymap.set('n', '<C-Right>', '<C-w>>')

vim.keymap.set("n", "<leader>n", toggle_number, { silent = true })

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers)


vim.keymap.set({'n', 't'}, '<C-t>', '<cmd>ToggleTerm<CR>')

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })



vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { silent = true, desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { silent = true, desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", { silent = true, desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>xf", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { silent = true, desc = "LSP (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { silent = true, desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { silent = true, desc = "Quickfix List (Trouble)" })
