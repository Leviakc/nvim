return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		--    "nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
		'JoosepAlviste/nvim-ts-context-commentstring',
		"HiPhish/nvim-ts-rainbow2",
		"windwp/nvim-ts-autotag"
	},
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"bash",
				"css",
				"go",
				"gomod",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"python",
				"json",
				"jsdoc",
				"rust",
				"svelte",
				"typescript",
				"vim",
				"yaml",
			},
			-- List of parsers to ignore installing (for "all")
			ignore_install = { "html" },
			highlight = {
				enable = true,
			},
			disable = { 'html' },
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = false,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			refactor = {
				highlight_definitions = { enable = true },
				smart_rename = {
					enable = false,
					keymaps = {
						smart_rename = "trr",
					},
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
					},
				},
			},
			autotag = {
				enable = true,
			},
			rainbow = {
				enable = true,
				-- list of languages you want to disable the plugin for
				disable = { 'html' },
				-- Which query to use for finding delimiters
				query = 'rainbow-parens',
				-- Highlight the entire buffer all at once
				strategy = require('ts-rainbow').strategy.global,
				--hlgroups = {}
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false
			}
		}
	end,
}
