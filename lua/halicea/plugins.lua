local themes = {
    { "folke/tokyonight.nvim" },
    { "navarasu/onedark.nvim" },
    { "shaunsingh/nord.nvim" },
    { "gzagatti/vim-leuven-theme" },
    { "nvim-tree/nvim-web-devicons" },
    { "yorik1984/newpaper.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
}

local personal = {
    {
        "42dotmk/roam",
        event = "VeryLazy",
        config = function()
            require("roam").setup({})
        end,
    },
    {
        "42dotmk/dirmark",
        event = "VeryLazy",
        config = function()
            require("dirmark").setup({})
        end,
    },
}

local textHelpers = {
    {
        "xiyaowong/telescope-emoji.nvim",
        event = "VeryLazy",
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "VeryLazy",
    },
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup({})
        end,
    },
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
}

local lsp = {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
    },

    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
    },
    {
        "hrsh7th/cmp-buffer",
        event = "VeryLazy",
    },
    {
        "hrsh7th/cmp-path",
        event = "VeryLazy",
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "Issafalcon/lsp-overloads.nvim" },
    { "ray-x/lsp_signature.nvim" },
}

local snippets = {
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({ path = "~/projects/halicea/snippets" })
        end
    },
    {
        "rafamadriz/friendly-snippets",
        event = "VeryLazy",
    },
    {
        'saadparwaiz1/cmp_luasnip',
        event = "VeryLazy",
    },
}

local nav_helpers = {
    { "tpope/vim-fugitive" },
    { "mbbill/undotree" },
    { "tpope/vim-eunuch" },
    { 'akinsho/toggleterm.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        event = "VeryLazy",
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
    { "nvim-tree/nvim-tree.lua",   config = function() require("nvim-tree").setup({}) end },
    { "folke/zen-mode.nvim",       config = function() require("zen-mode").setup({}) end },
    { "0x00-ketsu/maximizer.nvim", config = function() require("maximizer").setup({}) end },
    { 'stevearc/oil.nvim',         config = function() require('oil').setup({}) end,      dependencies = { "nvim-tree/nvim-web-devicons" } },
    {
        "harrisoncramer/gitlab.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "stevearc/dressing.nvim",     -- Recommended but not required. Better UI for pickers.
            "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
        },
        enabled = true,
        build = function() require("gitlab.server").build(true) end, -- Builds the Go binary
        config = function()
            require("gitlab").setup()
        end,
    },
}
if GetOS() == "unix" then
    table.insert(nav_helpers, { "christoomey/vim-tmux-navigator" })
    table.insert(nav_helpers, { "preservim/vimux" })
end

local code_helpers = {
    -- code_helpers
    { "jmederosalvarado/roslyn.nvim" },
    { "mg979/vim-visual-multi" },
    { "kylechui/nvim-surround",       config = function() require("nvim-surround").setup({}) end },
    { "numToStr/Comment.nvim",        config = function() require("Comment").setup() end },
    { "iamcco/markdown-preview.nvim", build = function() vim.fn["mkdp#util#install"]() end },
    { "windwp/nvim-autopairs",        config = function() require("nvim-autopairs").setup({}) end },
    { 'norcalli/nvim-colorizer.lua',  config = function() require('colorizer').setup() end },
    { "folke/trouble.nvim",           config = function() require("trouble").setup({}) end },
    { "folke/todo-comments.nvim",     dependencies = { "nvim-lua/plenary.nvim" } },
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
        "Hoffs/omnisharp-extended-lsp.nvim",
        config = function()
            require("lspconfig").omnisharp.setup({ handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler } })
        end
    },
}
if GetOS() == "unix" then
    table.insert(code_helpers, { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", } })
end
local debug_helpers = {
    {
        "nvim-neotest/nvim-nio",
        event = 'VeryLazy',
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        event = 'VeryLazy',
    },
    {
        "mfussenegger/nvim-dap",
        event = 'VeryLazy',
    },
    {
        "rcarriga/nvim-dap-ui",
        event = 'VeryLazy',
        config = function() require("dapui").setup({}) end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        event = 'VeryLazy',
        config = function() require("nvim-dap-virtual-text").setup({}) end
    },
}
local ai_tools = {
    { "github/copilot.vim" },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require("codeium").setup({
    --         })
    --     end
    -- },
}

local other_tools = {
    {
        "folke/which-key.nvim",
        event = 'VeryLazy',
    },

    -- db
    {
        "tpope/vim-dadbod",
        event = 'VeryLazy',
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        event = 'VeryLazy',
    },
    {
        "kristijanhusak/vim-dadbod-completion",
        event = 'VeryLazy',
    },
    -- db end


    -- Org mode
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        event = 'VeryLazy',
        config = function()
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
                org_todo_keywords = { 'TODO', 'IN-PROGRESS', 'BLOCKED', 'FUTURE', '|', 'DONE', 'CANCELLED' },
                org_agenda_files = {'~/org/**/*', '~/org/meetings.org'},
                org_default_notes_file = '~/org/todo.org',
                org_hide_leading_stars = true,
            })
        end,
    },
    {
        'akinsho/org-bullets.nvim',
        event = 'VeryLazy',
        config = function()
            require('org-bullets').setup()
        end
    }
}

local experimental = {
    {
        "kkharji/sqlite.lua",
        event = 'VeryLazy',
    },
    { "jbyuki/venn.nvim" }

}
local allGroups = {
    themes,
    textHelpers,
    lsp,
    snippets,
    nav_helpers,
    code_helpers,
    debug_helpers,
    ai_tools,
    other_tools,
    experimental,
    personal,
}
local plugins = {}
for _, group in pairs(allGroups) do
    for _, plugin in pairs(group) do
        table.insert(plugins, plugin)
    end
end
require('lazy').setup(plugins)

