-- Suppressed Stuff
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Options
vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- Show diagnostics inline (off by default)
vim.diagnostic.config({ virtual_text = true })

-- Plugins (built-in manager, installs on first start)
vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

-- Keybinds
vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<leader>g', '<cmd>FzfLua live_grep<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<cr>')

vim.keymap.set('n', '<leader>e', '<cmd>Explore<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>=', vim.lsp.buf.format)

vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })

-- Language servers: each is a command, filetypes, and project root markers
vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'requirements.txt', '.git' },
  settings = { python = { analysis = { diagnosticMode = 'openFilesOnly' } } },
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = {
        -- Adjust these globs to wherever your manifests live
        kubernetes = { 'k8s/**/*.yaml', 'manifests/**/*.yaml' },
      },
    },
  },
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
})

vim.lsp.enable({ 'terraformls', 'pyright', 'gopls', 'ts_ls', 'yamlls', 'bashls' })

-- Per-buffer setup once a server attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
  end,
})

-- Lsp menu configs
vim.o.autocomplete = true
vim.opt.complete:append('o')
vim.o.autocompletedelay = 700

-- Copy through the terminal (OSC 52) so yanks reach the clipboard of the machine you're typing on.
-- Windows Terminal can't answer OSC 52 paste requests, so paste reads Neovim's own register.
local osc52 = require('vim.ui.clipboard.osc52')
local function paste_from_register()
  return { vim.fn.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
end
vim.g.clipboard = {
  name = 'OSC 52 (copy only)',
  copy = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
  paste = { ['+'] = paste_from_register, ['*'] = paste_from_register },
}

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

-- File watching is off by default on Linux; without it servers miss files created after startup
vim.lsp.config('*', {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
  },
})


-- Syntax
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local highlighted_filetypes = { 'python', 'go', 'terraform', 'typescript', 'javascript', 'yaml', 'bash' }

require('nvim-treesitter').install({ 'python', 'go', 'hcl', 'terraform', 'typescript', 'javascript', 'yaml', 'bash' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = highlighted_filetypes,
  callback = function() vim.treesitter.start() end,
})
