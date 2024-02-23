return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    -- make sure mason installs the server
    ---@type lspconfig.options
    servers = {
      tailwindcss = {},
      astro = {
        cmd = { "/home/gomen/.local/share/nvim/mason/bin/astro-ls", "--stdio" },
        init_options = { typescript = {} },
        aautostart = true,
      },
    },
  },
}
