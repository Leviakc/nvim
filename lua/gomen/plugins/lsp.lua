return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    {
      -- Optional
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd, "MasonUpdate")
      end,
    },
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },     -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "L3MON4D3/LuaSnip" },             -- Required
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" }, -- opt
  },
  config = function()
    -- LSP config
    local lsp = require("lsp-zero").preset({})
    local defaults = require("cmp.config.default")()
    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, opts)
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, opts)
      vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
      end, opts)
      vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
      end, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
      end, opts)
      vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
      end, opts)
      vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
      end, opts)
      vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
      end, opts)
    end)

    lsp.format_on_save({
      servers = {
        ["lua_ls"] = { "lua" },
        ["rust_analyzer"] = { "rust" },
        ["cssls"] = { "css", "scss" },
        -- ["null-ls"] = { "html", "lua", "css", "typepcript", "typescriptreact" },
        ["eslint-lsp"] = { "typepcript", "javascript", "prettier", "typescriptreact" },
      },
    })

    lsp.ensure_installed({
      -- Replace these with whatever servers you want to install
      "tsserver",
      "cssls",
      "astro",
      "html",
      "sqlls",
      "unocss",
      "tailwindcss",
      -- "js-debug-adapter",
      "eslint",
      "rust_analyzer",
    })

    lsp.set_sign_icons({
      error = "",
      warn = "",
      hint = "",
      info = "",
      other = "",
    })

    -- (Optional) Configure lua language server for neovim
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "rust_analyzer",
        "eslint_lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "tailwindcss",
      },
    })

    local lsp = require("lsp-zero")
    lsp.extend_cmp()

    -- config to setup tailwindcss-colorizer-cmp
    lsp.setup_nvim_cmp({
      formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter,
      },
    })
    -- require('lspconfig').tsserver.setup({
    -- 	on_attach = function(client, bufnr)
    -- 		lsp.default_keymaps({ buffer = bufnr })
    -- 	end
    -- })

    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()

    -- CMP

    local cmp = require("cmp")
    local cmp_action = require("lsp-zero").cmp_action()
    local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      sources = cmp.config.sources({
        { name = "copilot",  group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      }),

      mapping = {
        -- `Enter` key to confirm completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Ctrl+Space to trigger completion menu
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select_opts),
        -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
        -- if cmp.visible() and has_words_before() then
        -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        -- else
        -- fallback()
        -- end
        -- end),
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select_opts),
        -- Navigate between snippet placeholder
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        --['<S-TAB>'] = cmp.mapping(function()
        --	if cmp.visible() then
        --		cmp.select_prev_item(cmp_select_opts)
        --	else
        --		cmp.complete()
        --	end
        --end),
        --['<TAB>'] = cmp.mapping(function()
        --	if cmp.visible() then
        --		cmp.select_next_item(cmp_select_opts)
        --	else
        --		cmp.complete()
        --	end
        --end),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        documentation = {
          max_height = 15,
          max_width = 60,
        },
      },
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          local short_name = {
            nvim_lsp = "LSP",
            nvim_lua = "nvim",
          }

          local menu_name = short_name[entry.source.name] or entry.source.name

          item.menu = string.format("[%s]", menu_name)
          return item
        end,
      },
    })
  end,
}
