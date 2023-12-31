return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	lazy = true,
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>nt", "<cmd>NeoTreeShowToggle<CR>", desc = "Neotree toggle" },
		{ "<leader>nT", "<cmd>NeoTreeShowToggle<CR>", desc = "Neotree toggle" },
		-- { "<cmd>lua require('telescope.builtin').find_files({cwd = '%:h'}, opts)<cr>" }
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "left",
				width = 30,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
			},
			filesystem = {
				follow_current_file = true,
				bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
				cwd_target = {
					sidebar = "tab", -- sidebar is when position = left or right
					current = "window" -- current is when position = current
				},
			},
			actions = {
				change_dir = {
					global = true
				}
			}
		})
	end
}
