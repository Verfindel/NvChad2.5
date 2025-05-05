return {
  {
    "williamboman/mason.nvim",
    -- load early so :Mason* commands exist
    priority = 100,
    config = function()
      require("mason").setup {
        -- custom registries go _before_ the core registry:
        registries = {
          "github:Crashdummyy/mason-registry",
          "github:mason-org/mason-registry",
        },
        -- (any other Mason settings go here)
      }
    end,
  },
  { "lewis6991/gitsigns.nvim", version = "*" },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
      -- NOTE: You must configure `cmd` in `config.cmd` unless you have installed via mason
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "theprimeagen/harpoon",
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
    dependencies = {
      "nvimdev/lspsaga.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "svelte",
        "rust",
        "zig",
        "sql",
        "markdown",
        "json",
        "dockerfile",
        "yaml",
        "toml",
        "go",
        "helm",
        "c_sharp"
      },
    },
  },
}
