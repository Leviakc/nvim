return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "VeryLazy", "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local null_ls = require("null-ls")

    -- register any number of sources simultaneously
    local sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.jsonlint,
      -- null_ls.builtins.diagnostics.ktlint,
      null_ls.builtins.diagnostics.markdownlint,
      -- null_ls.builtins.diagnostics.protoc_gen_lint,
    }

    null_ls.setup({ sources = sources })
  end,
}
-- null_ls.builtins.formatting.prettier.with({
-- 	filetypes = {
-- 		"html",
-- 		"css",
-- 		"lua",
-- 		"rust",
-- 		"astro",
-- 		"scss",
-- 		"json",
-- 		"yaml",
-- 		"javascript",
-- 		"typescript",
-- 		"javascriptreact",
-- 		"typescriptreact",
-- 	},
-- }),

-- null_ls.builtins.formatting.eslint.with({
-- 	"javascript",
-- 	"typescript",
-- 	"javascriptreact",
-- 	"typescriptreact",
-- }),
