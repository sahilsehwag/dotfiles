local LANGUAGE_VS_SETTINGS = {
  javascript = {
    formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
    formatStdin = true,
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    lintIgnoreExitCode = true,
  },
  lua = {
    formatCommand = 'lua-format -i',
    formatStdin = true,
  },
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob('.eslintrc*', 0, 1)
  if not vim.tbl_isempty(eslintrc) then
    return true
  end
  if vim.fn.filereadable('package.json') then
    if vim.fn.json_decode(vim.fn.readfile('package.json'))['eslintConfig'] then
      return true
    end
  end
  return false
end

return function(config)
  require('lspconfig').efm.setup({
    on_attach = function(client, bufnr)
      config.on_attach(client, bufnr)

      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.goto_definition     = false
      client.resolved_capabilities.rename              = false
      client.resolved_capabilities.hover               = false
      client.resolved_capabilities.completion          = false
      set_lsp_config(client)
    end,
    root_dir = function()
      if not eslint_config_exists() then
        return nil
      end
      return vim.fn.getcwd()
    end,
    filetypes = {
      'lua',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescript.tsx',
      'typescriptreact'
    },
    settings = {
      rootMarkers = {
        '.git/',
        'package.json',
      },
      languages = {
        lua                = {LANGUAGE_VS_SETTINGS.lua},
        javascript         = {LANGUAGE_VS_SETTINGS.javascript},
        javascriptreact    = {LANGUAGE_VS_SETTINGS.javascript},
        ['javascript.jsx'] = {LANGUAGE_VS_SETTINGS.javascript},
        typescript         = {LANGUAGE_VS_SETTINGS.javascript},
        typescriptreact    = {LANGUAGE_VS_SETTINGS.javascript},
        ['typescript.tsx'] = {LANGUAGE_VS_SETTINGS.javascript},
      },
    },
  })
end
