-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
-- local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

require("mason").setup()
local mason_lspconfig = require "mason-lspconfig"
local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls", "omnisharp"}
local rounded_border_handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
  }
})

mason_lspconfig.setup_handlers({
  function (server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = rounded_border_handlers,
    })
  end,
  --["omnisharp"] = function()
	--	lspconfig["omnisharp"].setup({
	--		on_attach = on_attach,
	--		capabilities = capabilities,
	--		root_dir = function(fname)
	--			local primary = lspconfig.util.root_pattern("*.sln")(fname)
	--			local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
	--			return primary or fallback
	--		end,
	--		analyze_open_documents_only = true,
	--		organize_imports_on_format = true,
	--		handlers = vim.tbl_extend("force", rounded_border_handlers, {
	--			["textDocument/definition"] = require("omnisharp_extended").handler,
	--		}),
	--	})
	--end,
  ["lua_ls"] = function()
		local lua_runtime_path = vim.split(package.path, ";")
		table.insert(lua_runtime_path, "lua/?.lua")
		table.insert(lua_runtime_path, "lua/?/init.lua")

		require("lspconfig")["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,

			handlers = rounded_border_handlers,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = lua_runtime_path,
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
})


