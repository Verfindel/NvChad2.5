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
    "omnisharp",
 --   "tsserver"
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
  ["omnisharp"] = function()
		lspconfig["omnisharp"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function(fname)
				local primary = lspconfig.util.root_pattern("*.sln")(fname)
				local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
				return primary or fallback
			end,
			analyze_open_documents_only = true,
			organize_imports_on_format = true,
			handlers = vim.tbl_extend("force", rounded_border_handlers, {
				["textDocument/definition"] = require("omnisharp_extended").handler,
			}),
		})
	end,
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


-- lsps with default config
-- for _, lsp in ipairs(servers) do
--   if lsp == "omnisharp" then
--     lspconfig[lsp].setup({
--       on_attach = on_attach,
--       capabilities = capabilities,
--       handlers = vim.tbl_extend("force", rounded_border_handlers, {
--         ["textDocument/definition"] = require("omnisharp_extended").handler,
--       }),
--       -- Enables support for reading code style, naming convention and analyzer
--       -- settings from .editorconfig.
--       enable_editorconfig_support = true,
--       -- If true, MSBuild project system will only load projects for files that
--       -- were opened in the editor. This setting is useful for big C# codebases
--       -- and allows for faster initialization of code navigation features only
--       -- for projects that are relevant to code that is being edited. With this
--       -- setting enabled OmniSharp may load fewer projects and may thus display
--       -- incomplete reference lists for symbols.
--       enable_ms_build_load_projects_on_demand = false,
--       -- Enables support for roslyn analyzers, code fixes and rulesets.
--       enable_roslyn_analyzers = true,
--       -- Specifies whether 'using' directives should be grouped and sorted during
--       -- document formatting.
--       organize_imports_on_format = true,
--       -- Enables support for showing unimported types and unimported extension
--       -- methods in completion lists. When committed, the appropriate using
--       -- directive will be added at the top of the current file. This option can
--       -- have a negative impact on initial completion responsiveness,
--       -- particularly for the first few completion sessions after opening a
--       -- solution.
--       enable_import_completion = true,
--       -- Specifies whether to include preview versions of the .NET SDK when
--       -- determining which version to use for project loading.
--       sdk_include_prereleases = true,
--       -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--       -- true
--       analyze_open_documents_only = false,
--       root_dir = function(fname)
--         local primary = lspconfig.util.root_pattern("*.sln")(fname)
--         local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
--         return primary or fallback
--       end,
--     })
--   else
--     lspconfig[lsp].setup {
--       on_attach = on_attach,
--       on_init = on_init,
--       capabilities = capabilities,
--     }
--   end
-- end
--
-- -- typescript
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
