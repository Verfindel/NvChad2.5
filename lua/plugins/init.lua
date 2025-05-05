return {
  { "lewis6991/gitsigns.nvim", version = "*" },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "williamboman/mason.nvim",
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
	'nvimdev/lspsaga.nvim'
    }
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
        "helm"
      },
    },
  },
}
