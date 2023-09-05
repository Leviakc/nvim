return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    "anuvyklack/hydra.nvim",
  },

  event = "VeryLazy",
  -- keys = { { "<leader>nd", "<cmd>DapToggleBreakpoint<CR>", desc = "Open Debug menu" } },
  keys = { { "<leader>de", desc = "Open Debug menu" } },
  config = function()
    require("gomen.config.dap")
  end,
}

-- local dap = require("dap")
--
-- dap.adapters["pwa-node"] = {
-- 	type = "server",
-- 	host = "127.0.0.1",
-- 	port = 8123,
-- 	executable = {
-- 		command = "js-debug-adapter",
-- 	},
-- }
--
-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	dap.configurations[language] = {
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 			runtimeExecutable = "node",
-- 		},
-- 	}
-- end
--
-- -- local M = {}
-- --
-- -- M.dap = {
-- --   plugin = true,
-- --   n = {},
-- -- }
-- --
-- -- return M
