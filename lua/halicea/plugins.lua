require('lazy').setup({
    { "folke/which-key.nvim" },
    -- themes
    { "folke/tokyonight.nvim" },
    { "navarasu/onedark.nvim" },
    { "shaunsingh/nord.nvim" },
    { "gzagatti/vim-leuven-theme" },
    { "nvim-tree/nvim-web-devicons" },
    { "yorik1984/newpaper.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "catppuccin/nvim",                 name = "catppuccin", priority = 1000 },
    -- end themes

    -- text_helpers
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup({})
        end,
    },
    { "xiyaowong/telescope-emoji.nvim" },
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            local ibl = require("ibl")
            ibl.setup({})
            ibl.update { enabled = false }
        end
    },
    -- end text_helpers
    -- db
    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-ui" },
    { "kristijanhusak/vim-dadbod-completion" },
    -- db end

    -- ai
    { "github/copilot.vim" },
    {
        "dpayne/CodeGPT.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("codegpt.config")
        end,
    },
    -- end ai

    -- lsp
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    { "jose-elias-alvarez/null-ls.nvim" },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
        end,
    },
    { "Issafalcon/lsp-overloads.nvim" },
    { "ray-x/lsp_signature.nvim" },
    -- end lsp

    -- nav_helpers
    -- telescope
    { "nvim-telescope/telescope-dap.nvim" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").load_extension("dap")
            require("telescope").load_extension("emoji")
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        vertical = { height = 0.3 },
                    },
                },
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        theme = "ivy",
                        previewer = false,
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                                ["<c-a>"] = "toggle_selection",
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({})
        end,
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({})
        end,
    },
    { "christoomey/vim-tmux-navigator" },
    { "preservim/vimux" },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('oil').setup({});
        end,
    },

    -- end nav_helpers
    -- code_helpers
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    { "tpope/vim-fugitive" },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "org" },
                },
                ensure_installed = { "org" },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { "mbbill/undotree" },
    { "tpope/vim-eunuch" },
    { "nvim-treesitter/playground" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    { "jmederosalvarado/roslyn.nvim" },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        config = function()
            local config = {
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").handler,
                },
            }
            require("lspconfig").omnisharp.setup(config)
        end,
    },
    { "mg979/vim-visual-multi" },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- -- end code_helpers
    -- -- debug_helpers
    { "nvim-telescope/telescope-dap.nvim" },
    { "mfussenegger/nvim-dap" },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dapui").setup({})
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    },

    -- end debug_helpers
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        event = 'VeryLazy',
        config = function()
            -- Load treesitter grammar for org
            require('orgmode').setup_ts_grammar()

            -- Setup treesitter
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' },
                },
                ensure_installed = { 'org' },
            })

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/org/**/*',
                org_default_notes_file = '~/org/notes.org',
            })
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", },
    },
})
