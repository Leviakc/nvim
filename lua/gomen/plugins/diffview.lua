return {
	"sindrets/diffview.nvim",
	lazy = true,
	keys = {
		{
			"<leader>do",
			"<cmd>:DiffviewOpen<cr>",
			desc = "Opens a new Diffview that compares against the current index",
		},
		{ "<leader>dc", "<cmd>:DiffviewClose<cr>", desc = "Close the Diffview file" },
		{ "<leader>dh", "<cmd>:DiffviewFileHistory<cr>", desc = "Show file history" },
	},
}
