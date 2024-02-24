local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    'lua_ls',
    'rust_analyzer',
    'gopls',
    'texlab',
    'ltex',                 -- Grammar + Spelling
    'jedi_language_server', -- Python
    'denols',
    'elixirls',
})

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>jh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>jd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>jn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>jp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ja", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>jrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>jrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>jws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.rust_analyzer.setup({})
lspconfig.gopls.setup({})
lspconfig.texlab.setup({})
lspconfig.ltex.setup({})
lspconfig.jedi_language_server.setup({})
--lspconfig.tsserver.setup {}
lspconfig.volar.setup {
    root_dir = lspconfig.util.root_pattern("vite.config.ts"),
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
        typescript = {
            tsdk = '/usr/local/lib/node_modules/typescript/lib'
        }
    }
}
lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})
lspconfig.elixirls.setup({})

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        -- `Enter` key to confirm completion
        ['<C-l>'] = cmp.mapping.confirm({ select = true }),
        ['<C-CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<Right>'] = cmp.mapping.confirm({ select = true }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.abort(),
        -- ['<Left>'] = cmp.mapping.abort(),
        --['<Esc>'] = cmp.mapping.abort(),
        -- Navigate between suggestions
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})
