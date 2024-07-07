vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client == nil then
            return
        end

        if client.server_capabilities.signatureHelpProvider then
            require("lsp-overloads").setup(client, {})
        end
        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

    if client.name == "omnisharp" then
        --Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(opts.buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definitions()<cr>", opts)
    else
        vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    end
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    require('lspconfig')[server].setup({
        handlers = {
            ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            }),
        },
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        default_setup,
        omnisharp = function()
            require('lspconfig').omnisharp.setup({
                capabilities = lsp_capabilities,
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").handler,
                }
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })
        end,
        yamlls = function()
            require('lspconfig').yamlls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    customTags = { "!reference" },
                }
            })
        end,

        powershell_es = function()
            require('lspconfig').powershell_es.setup({
                capabilities = lsp_capabilities,
                settings = {
                    bundle_path = '/home/halicea/.local/share/nvim/mason/packages/powershell-editor-services'
                },
            })
        end
    },
})

-- completion
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
