--utilities
local rootPattern = require('lspconfig').util.root_pattern

--constants
local ROOT_PATH = 'plugins/lsp/lspconfig'
local SERVERS_PATH = ROOT_PATH .. '/servers'

local SERVERS = {
  'efm',
  'sumneko_lua',
}

for i,server in ipairs(SERVERS) do
  require(SERVERS_PATH .. '/' .. server)
end

--HELPERS
--CORE
  --CAPABILITIES
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          'documentation',
          'detail',
          'additionalTextEdits',
        }
      }
--GENERAL
  --DIAGNOSTICLS
    --require('lspconfig').diagnosticls.setup({})
	--CODEQLLS
    --require('lspconfig').codeqlls.setup{}
--COMMON
	--VIM
		--VIMLS
      require('lspconfig').vimls.setup({})
	--PYTHON
		--PYRIGHT
      require('lspconfig').pyright.setup{}
		--JEDI-LANGUAGE-SERVER
      --require('lspconfig').jedi_language_server.setup{}
		--PYLS
      --require('lspconfig').pyls.setup{}
		--PYLS-MS
      --require('lspconfig').pyls_ms.setup{}
--FRONTEND
	--HTML
    require('lspconfig').html.setup{}
	--CSS
    require('lspconfig').cssls.setup{}
	--JAVASRIPT
		--TSSERVER
      require('lspconfig').tsserver.setup({
        cmd = {"typescript-language-server", "--stdio"};
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_dir = rootPattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        --root_dir = rootPattern("node_modules", "tsconfig.json", "jsconfig.json", ".git"),
        capabilities = capabilities,
      })
		--ROME
      --require('lspconfig').rome.setup{}
		--DENOLS
      --require('lspconfig').denols.setup{}
		--FLOW
      --require('lspconfig').flow.setup{}
	--FRAMEWORKS
		--VUELS
      require('lspconfig').vuels.setup{}
		--ANGULARLS
      require('lspconfig').angularls.setup{}
		--SVELTE
      require('lspconfig').svelte.setup{}
--FUNCTIONAL
	--HASKELL
		--HLS
      require('lspconfig').hls.setup{}
	--FSHARP
		--FSAUTOCOMPLETE
      require('lspconfig').fsautocomplete.setup{}
  --LISP
	--ELM
		--ELMLS
      require('lspconfig').elmls.setup{}
	--NIM
		--NIMLS
      require('lspconfig').nimls.setup{}
	--CLOJURE
		--CLOJURE-LSP
      require('lspconfig').clojure_lsp.setup{}
	--PURESCRIPT
		--PURESCRIPTLS
      require('lspconfig').purescriptls.setup{}
	--OCAML
		--OCAMLLS
      require('lspconfig').ocamlls.setup{}
		--OCAMLLSP
      --require('lspconfig').ocamllsp.setup{}
	--ELIXIR
		--ELIXIRLS
      require('lspconfig').elixirls.setup{}
	--ERLANG
		--ERLANGLS
      require('lspconfig').erlangls.setup{}
	--GROOVY
		--GROOVYLS
      require('lspconfig').groovyls.setup{}
--SYSTEMS
	--C|CPP
		--CCLS
      require('lspconfig').ccls.setup{}
		--CLANGD
      require('lspconfig').clangd.setup{}
	--GO
		--GOPLS
      require('lspconfig').gopls.setup{}
	--RUST
		--RUST-ANALYZER
      require('lspconfig').rust_analyzer.setup{}
		--RLS
      --require('lspconfig').rls.setup{}
	--SWIFT
		--SOURCEKIT
      require('lspconfig').sourcekit.setup{}
--SCRIPTING
	--RUBY
		--SOLARGRAPH
      require('lspconfig').solargraph.setup{}
		--SORBET
      require('lspconfig').sorbet.setup{}
	--PERL
		--PERLLS
      require('lspconfig').perlls.setup{}
--ICLS
	--JAVA
		--JDTLS
      require('lspconfig').jdtls.setup{}
	--SCALA
		--METALS
      require('lspconfig').metals.setup{}
	--CSHARP
		--OMNISHARP
      require('lspconfig').omnisharp.setup{}
	--KOTLIN
		--KOTLIN-LANGUAGE-SERVER
      require('lspconfig').kotlin_language_server.setup{}
--DATASCIENCE
	--R
		--R-LANGUAGE-SERVER
      require('lspconfig').r_language_server.setup{}
--DBMS
	--SQLLS
    require('lspconfig').sqlls.setup{}
    --require('lspconfig').sqls.setup{}
	--GRAPHQL
    require('lspconfig').graphql.setup{}
--SHELL
	--BASHLS
    require('lspconfig').bashls.setup{}
	--RNIX
    require('lspconfig').rnix.setup{}
--DSL
	--JSONLS
    require('lspconfig').jsonls.setup{}
	--YAMLLS
    require('lspconfig').yamlls.setup{}
  --DHALL
    --require('lspconfig').dhall_lsp_server.setup{}
	--CMAKE
    require('lspconfig').cmake.setup{}
	--DOCKERLS
    require('lspconfig').dockerls.setup{}
	--TERRAFORMLS
    require('lspconfig').terraformls.setup{}
	--TEXLAB
    require('lspconfig').texlab.setup{}
--RANDOM
	--DART
		--DARTLS
      require('lspconfig').dartls.setup{}
	--HAXE
		--HAXE-LANGUAGE-SERVER
      require('lspconfig').haxe_language_server.setup{}
	--CRYSTAL
		--SCRY
      require('lspconfig').scry.setup{}
  --JULIA
    --JULIALS
      require('lspconfig').julials.setup{}
