local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
  local opts = {}
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

return {
  installServers = function()
    local cmds = {
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/angularls                    @angular/language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/bash                         bash-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/diagnosticls                 diagnostic-languageserver',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/dockerfile                   dockerfile-language-server-nodejs',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/dotls                        dot-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/elm                          elm-lsp',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/ember                        @lifeart/ember-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/graphql                      graphql-language-service-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/graphql                      graphql-language-service-cli',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/ocamlls                      ocaml-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/php                          intelephense',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/prismals                     @prisma/language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/purescript                   purescript-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/rome                         rome',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/sqlls                        sql-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/stylelint_lsp                stylelint-lsp',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/svelte                       svelte-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/tailwindcss_npm              tailwindcss-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/tsserver                     typescript-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/vim                          vim-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/vscode-langservers-extracted vscode-langservers-extracted',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/vuels                        vls',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/vuels                        vue-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/yaml                         yaml-language-server',
      'npm  install --prefix ~/.local/share/nvim/lsp_servers/python                       pyright',
      'pip3 install --target=~/.local/share/nvim/lsp_servers/python                       python-language-server',
    }

    for _, cmd in ipairs(cmds) do
      vim.fn.system(cmd)
    end
  end,
}

