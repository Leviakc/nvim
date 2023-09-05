return {
	"ziontee113/icon-picker.nvim",
	lazy = true,
	keys = {
		{ "<Leader>i", "<cmd>IconPickerNormal<cr>" },
		{ "<Leader>y", "<cmd>IconPickerYank<cr>" },
	},
	config = function()
		require("icon-picker").setup({
			disable_legacy_commands = true,
		})
	end,
}
