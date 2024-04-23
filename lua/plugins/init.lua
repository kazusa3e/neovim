return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    keys = {
      { "qq", mode = "n", desc = "Comment toggle current line" },
      { "q", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "q", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "QQ", mode = "n", desc = "Comment toggle current block" },
      { "Q", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "Q", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    opts = {
      padding = true,
      sticky = false,
      extra = nil,
      toggler = { line = "qq", block = "QQ" },
      opleader = { line = "q", block = "Q" },
      mappings = { basic = true, extra = false },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        -- "html-lsp",
        -- "css-lsp",
        -- "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        -- "html",
        -- "css",
      },
    },
  },
}
