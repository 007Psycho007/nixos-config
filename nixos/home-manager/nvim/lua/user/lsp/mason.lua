local dap = require("dap")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {'pyright', 'gopls', 'terraformls','tsserver','vuels'}
})
require("mason-nvim-dap").setup({
  ensure_installed = { "debugpy", "delve" },
  automatic_installation = true,
})

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
})
