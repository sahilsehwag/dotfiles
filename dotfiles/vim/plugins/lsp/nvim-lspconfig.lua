--SERVERS
  require('lspconfig').diagnosticls.setup{}
  require('lspconfig').efm.setup{}

  require('lspconfig').vimls.setup{}
  require('lspconfig').sumneko_lua.setup{}

  require('lspconfig').pyright.setup{}
  require('lspconfig').jedi_language_server.setup{}
  require('lspconfig').pyls.setup{}
  require('lspconfig').pyls_ms.setup{}
  require('lspconfig').r_language_server.setup{}

  require('lspconfig').html.setup{}
  require('lspconfig').cssls.setup{}
  require('lspconfig').tsserver.setup{}
  require('lspconfig').rome.setup{}
  require('lspconfig').denols.setup{}
  require('lspconfig').flow.setup{}

  require('lspconfig').vuels.setup{}
  require('lspconfig').angularls.setup{}
  require('lspconfig').svelte.setup{}

  require('lspconfig').metals.setup{}
  require('lspconfig').omnisharp.setup{}
  require('lspconfig').jdtls.setup{}

  require('lspconfig').jsonls.setup{}
  require('lspconfig').yamlls.setup{}
  require('lspconfig').dhall_lsp_server.setup{}

  require('lspconfig').graphql.setup{}
  require('lspconfig').sqlls.setup{}
  require('lspconfig').sqls.setup{}

  require('lspconfig').bashls.setup{}
  require('lspconfig').rnix.setup{}

  require('lspconfig').cmake.setup{}
  require('lspconfig').dockerls.setup{}
  require('lspconfig').terraformls.setup{}

  require('lspconfig').ccls.setup{}
  require('lspconfig').clangd.setup{}
  require('lspconfig').sourcekit.setup{}
  require('lspconfig').rust_analyzer.setup{}
  require('lspconfig').rls.setup{}
  require('lspconfig').gopls.setup{}

  require('lspconfig').hls.setup{}
  require('lspconfig').elmls.setup{}
  require('lspconfig').nimls.setup{}
  require('lspconfig').fsautocomplete.setup{}
  require('lspconfig').clojure_lsp.setup{}
  require('lspconfig').ocamlls.setup{}
  require('lspconfig').ocamllsp.setup{}

  require('lspconfig').elixirls.setup{}
  require('lspconfig').erlangls.setup{}
  require('lspconfig').kotlin_language_server.setup{}
  require('lspconfig').dartls.setup{}
  require('lspconfig').groovyls.setup{}
  require('lspconfig').perlls.setup{}
  require('lspconfig').julials.setup{}
  require('lspconfig').purescriptls.setup{}
  require('lspconfig').haxe_language_server.setup{}
  require('lspconfig').scry.setup{}
  require('lspconfig').solargraph.setup{}
  require('lspconfig').sorbet.setup{}

  require('lspconfig').texlab.setup{}

  require('lspconfig').codeqlls.setup{}
--HIGHLIGHTS
  --LSP
    vim.fn.sign_define("LspDiagnosticsSignError"       , {text = " " , texthl="JatErrorFG"   , numhl = "" , linehl = ""})
    vim.fn.sign_define("LspDiagnosticsSignWarning"     , {text = " " , texthl="JatWarningFG" , numhl = "" , linehl = ""})
    vim.fn.sign_define("LspDiagnosticsSignInformation" , {text = " " , texthl="JatInfoFG"    , numhl = "" , linehl = ""})
    vim.fn.sign_define("LspDiagnosticsSignHint"        , {text = " " , texthl="JatHintFG"    , numhl = "" , linehl = ""})
