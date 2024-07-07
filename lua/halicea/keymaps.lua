local g = vim.g
local api = vim.api
local keymap = vim.keymap

local wk = require("which-key")
function Modal(name, ...)
    require("telescope.builtin")[name](...)
end

-- Copilot swap tab since compe takes the tab key
g.copilot_no_tab_map = true
g.copilot_assume_mapped = true
keymap.set(
    "i",
    "<C-b>",
    'copilot#Accept("<Return>")',
    { noremap = true, silent = true, expr = true, replace_keycodes = false }
)

keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
keymap.set({ "n", "x" }, "<C-p>", "<Plug>(YankyCycleForward)", { noremap = false })
keymap.set({ "n", "x" }, "<C-M-p>", "<Plug>(YankyCycleBackward)", { noremap = false })
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

wk.register({
    ["<Left>"] = { "4<C-w><", "dec width" },
    ["<Right>"] = { "4<C-w>>", "inc width" },
    ["<Up>"] = { "1<C-w>+", "inc height" },
    ["<Down>"] = { "1<C-w>-", "dec height" },
    ["<C-]>"] = { "<cmd>cnext<CR>", "next item" },
    ["<C-[>"] = { "<cmd>cprevious<CR>", "prev item" },
    ["<C-\\>"] = { "<cmd>copen<CR>", "open coc" },
    -- Debugging
    -- ["<c-s>"] = { ":lua require('dap').step_over()<cr>", "step-over" },
    -- ["<c-s-s>"] = { ":lua require('dap').step_into()<cr>", "step-into" },
    -- ["<c-a>"] = { ":lua require('dap').step_out()<cr>", "step-out" },
    -- ["<c-c>"] = { ":lua require('dap').continue()<cr>", "step-out" },
    -- ["<c-s-c>"] = { ":lua require('dap').close()<cr>", "step-out" },

    -- lsp
    g = {
        name = "goto",
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "definition" },
        l = { "<C-w>v<C-w>l<cmd>lua vim.lsp.buf.definition()<CR>", "peek-definition-right" },
        o = { "<C-w>v<C-w>lgf<CR>", "peek-definition-right" },
        r = { "<cmd>lua vim.lsp.buf.references()<CR>", "references" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "implementation" },
    },

    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover" },
    ["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "prev-diag" },
    ["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next-diag" },
})
wk.register({
    a = {
        name = "all the rest",
        a = { "<cmd>lua Modal('autocommands')<cr>", "code-actions" },
        b = { "<cmd>lua Modal('buffers')<cr>", "buffers" },
        c = { "<cmd>lua Modal('commands')<cr>", "commands" },
        C = { "<cmd>lua Modal('colorscheme')<cr>", "theme" },
        e = { "<cmd>Telescope emoji theme=ivy<cr>", "emoji" },
        f = { "<cmd>lua Modal('find_files')<cr>", "files" },
        g = { "<cmd>ChatGPT<cr>", "git" },
        q = { "<cmd>lua Modal('marks')<cr>", "marks" },
        m = { "<cmd>lua Modal('man_pages')<cr>", "man" },
        o = { "<cmd>lua Modal('vim_options')<cr>", "vim options" },
        r = { "<cmd>RoamOpenId<cr>", "roam-goto-id" },
    },
    b = {
        name = "buffers",
        b = { "<cmd>lua Modal('buffers')<cr>", "list" },
        d = { "<cmd>bd<cr>", "delete" },
        D = { "<cmd>bd!<cr>", "force delete" },
        n = { "<cmd>bn<cr>", "next" },
        p = { "<cmd>bp<cr>", "previous" },
        o = { "<C-^><cr>", "other" },
        r = { "<cmd>e! %<cr>", "refresh" },
        y = { "<cmd>CopyBufferPath<cr>", "copy-path" },

    },
    c = {
        name = "code",
        c = { "<Plug>(comment_toggle_linewise_current)", "comment" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "help" },
        w = {
            name = "+workspace",
            a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "wspace-add" },
            r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "wspace-rm" },
        },
        D = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "type-def" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "actions" },
        e = {
            name = "+errors",
            d = { "<cmd>Trouble diagnostics<cr>", "document" },
            w = { "<cmd>Trouble diagnostics<cr>", "workspace" },
        },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "loc-list" },
        f = { "<cmd>lua vim.lsp.buf.format { async = false }<CR>", "format" },
        s = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "symbols" },
        S = { "<cmd>lua require('luasnip.loaders').edit_snippet_files()<CR>", "symbols" },
    },
    d = {
        name = "debug",
        T = { ":DapTerminate<CR>", "debug-kill" },
        t = { ":DapToggleRepl<CR>", "toggle-repl" },
        d = { ":DapToggleBreakpoint<CR>", "bp-toggle" },
        f = { ":Telescope dap frames<CR>", "frames" },
        c = { ":lua require('telescope').extensions.dap.commands()<CR>", "commands" },
        b = { ":Telescope dap list_breakpoints<CR>", "breakpoints" },
        U = { ":lua require('dap').up()<CR>", "frame-up" },
        D = { ":lua require('dap').down()<CR>", "frame-down" },
        s = {
            name = "step",
            i = { ":lua require('dap').step_into()<CR>", "into" },
            o = { ":lua require('dap').step_over()<CR>", "over" },
            s = { ":lua require('dap').step_over()<CR>", "over" },
            u = { ":lua require('dap').step_out()<CR>", "out" },
        },
        r = {
            name = "run",
            d = { ":lua require('dap').continue()<CR>", "continue" },
            R = { ":lua require('dap').repl.open()<CR>", "repl" },
            t = { ":lua require('dap').run_to_cursor()<CR>", "run-to-cursor" },
        },
        i = { ":lua require('dap.ui.widgets').hover()<CR>", "variables" },
        h = { "<C-w>h<cmd>q<cr>", "win-del-left" },
        j = { "<C-w>j<cmd>q<cr>", "win-del-bellow" },
        k = { "<C-w>k<cmd>q<cr>", "win-del-above" },
        l = { "<C-w>l<cmd>q<cr>", "win-del-right" },
    },
    e = {
        name = "eval",
        e = { ":w<cr>:so %<cr>", "current file" },
        r = { "<cmd>e! %<cr>", "reload-current" },
        c = { "<cmd>so ~/.config/nvim/init.lua<cr>", "reload-config" },

        s = { "<cmd>e ~/scratch.lua<cr>", "scratch" },
        k = { "<cmd>e ~/.dotfiles/nvim/lua/halicea/keymaps.lua<cr>", "keymaps" },
        p = { "<cmd>e ~/.dotfiles/nvim/lua/halicea/plugins.lua<cr>", "plugins" },
    },
    f = {
        name = "file",
        c = { "<cmd>lua Modal('commands')<cr>", "commands" },
        f = { "<cmd>lua Modal('find_files', {no_ignore=true, no_ignore_parent=true, hidden=true})<cr>", "find" },
        n = { "<cmd>new<cr><C-w>L", "new" },
        r = { "<cmd>lua Modal('oldfiles')<cr>", "recent" },
        s = { "<cmd>w<cr>", "file save" },
        t = { "<cmd>lua Modal('filetypes')<cr>", "types" },
        p = { "<cmd>lua Modal('find_files',{search_dirs = {'~/.dotfiles'}})<cr>", "dotfiles" },
    },
    g = {
        name = "git",
        b = { "<cmd>Git blame<cr>", "blame" },
        c = { "<cmd>lua Modal('git_branches')<cr>", "branches" },
        f = { "<cmd>Git fetch<cr>", "fetch" },
        g = { "<cmd>Git<cr>", "status" },
        i = { "<cmd>Git init<cr>", "init" },
        l = { "<cmd>Git pull<cr>", "pull" },
        m = { "<cmd>MerginalToggle<cr>", "merge" },
        R = { "<cmd>Git reset --hard HEAD<cr>", "hard-reset" },
        p = { "<cmd>Git push<cr>", "push" },
        s = { "<cmd>Git<cr>", "status" },
    },
    h = {
        name = "help",
        h = { "<cmd>lua Modal('help_tags')<cr>", "tags" },
        m = { "<cmd>lua Modal('keymaps')<cr>", "keymaps" },
        t = { "<cmd>lua Modal('colorscheme')<cr>", "colorscheme" },
    },
    l = {
        name = "lsp",
        i = { "<cmd>LspInstall<CR> ", "install" },
        k = { "<cmd>LspStop<CR>", "stop" },
        l = { "<cmd>LspInfo<CR>", "status" },
        s = { "<cmd>LspStart<CR>", "start" },
    },
    m = {
        name = "marks",
        m = { "<cmd>lua require('dirmark').open()<cr>", "dir mark" },
        a = { "<cmd>lua require('dirmark').mark_cwd()<cr>", "add cwd" },
        e = { "<cmd>lua require('dirmark').open_marks_file()<cr>", "dir marks file" },
        r = { "<cmd>lua require('roam').search()<cr>", "roam" },
    },
    n = {
        name = "open",
        n = { "<cmd>Oil<cr>", "oil" },
        o = { "<cmd>Oil<cr>", "open" },
        f = { "<cmd>NvimTreeFindFile<cr>", "project find" },
        p = { "<cmd>NvimTreeToggle<cr>", "project" },
        m = { "<cmd>MarkdownPreviewToggle<cr>", "markdown" },
        d = { "<cmd>lua require('dapui').toggle()<cr>", "debug" },
    },
    p = {
        name = "plugins",
        c = { "<cmd>Lazy clean<cr>", "clean" },
        i = { "<cmd>Lazy sy<cr>", "install" },
        p = { "<cmd>Lazy home<cr>", "status" },
        s = { "<cmd>Lazy sync<cr>", "sync" },
        r = { "<cmd>so ~/.config/nvim/init.lua<cr>", "reload-config" },
    },
    q = {
        name = "quit",
        q = { "<cmd>q<cr>", "quit" },
        a = { "<cmd>qa<cr>", "quit all" },
        Q = { "<cmd>qa!<cr>", "quit all forced" },
    },
    r = {
        name = "repl/repeat",
        e = { "<cmd>@:<cr>", "vim-last" },
        t = { "<cmd>VimuxTogglePane<cr>", "toggle" },
        o = { "<cmd>VimuxOpenRunner<cr>", "open" },
        k = { "<cmd>VimuxCloseRunner<cr>", "kill" },
        c = { "<cmd>VimuxPromptCommand<cr>", "prompt" },
        r = { "<cmd>VimuxRunLastCommand<cr>", "run-last" },
        d = { "<cmd>VimuxCloseRunner<cr>", "close" },
        i = { "<cmd>VimuxInterruptRunner<cr>", "interrupt" },

        s = { "vip:<C-U>REPLSendLines<cr><esc>%", "send-paragraph" },
        a = { "ggVG:<C-U>REPLSendLines<cr><esc>", "send-all" },
    },
    s = {
        name = "search",
        d = { "<cmd>lua Modal('live_grep')<cr>", "in directory" },
        s = { "<cmd>lua Modal('current_buffer_fuzzy_find')<cr>", "buffer" },
    },
    t = {
        name = "toggles",
        z = { "<cmd>ZenMode<cr>", "zen" },
        l = { "<cmd>set nu! rnu!<cr>", "line-numbers" },
        L = { "<cmd>set nu rnu!<cr>", "line-numbers" },
        ["."] = { "<cmd>set list!<cr>", "special-chars" },
        w = { "<cmd>set wrap!<cr>", "wrap" },
        i = { "<cmd>IBLToggle<cr>", "indent" },
        h = { "<cmd>lua Modal('colorscheme')<cr>", "colorscheme" },
        d = { "<cmd>lua require('dapui').toggle()<cr>", "debug" },
        v = { "<cmd>lua Toggle_venn()<CR>", "toggle-venn" },
        b = {
            name = "background",
            l = { "<cmd><cmd>colorscheme leuven<cr>", "light" },
            d = { "<cmd>colorscheme nord<cr>", "dark" },
            L = {

                "<cmd>colorscheme leuven<cr><cmd>!~/.dotfiles/alacritty/alacritty-config -t papercolor_light<cr>",
                -- '<cmd>let ayucolor="light"<cr><cmd>colorscheme ayu-light<cr><cmd>!~/.dotfiles/alacritty/alacritty-config -t atom_one_light<cr>',
                "light+term",
            },
            D = {
                "<cmd>colorscheme nord<cr><cmd>!~/.dotfiles/alacritty/alacritty-config -t nord<cr>",
                -- '<cmd>let ayucolor="mirage"<cr><cmd>colorscheme ayu-mirage<cr><cmd>!~/.dotfiles/alacritty/alacritty-config -t nord<cr>',
                "dark+term",
            },
            t = { "<cmd>hi Normal guibg=NONE ctermbg=NONE<cr>", "transparent" },
        },
        t = { "<cmd>ToggleTerm<cr>", "terminal" },
        m = { "<cmd>lua require('maximizer').toggle()<CR>", "maximized" },
    },
    u = { "<cmd>UndotreeToggle<cr>", "undo tree" },
    w = {
        name = "window",
        d = { "<cmd>q<cr>", "quit" },
        h = { "<C-w>h", "go-left" },
        j = { "<C-w>j", "go-bellow" },
        k = { "<C-w>k", "go-above" },
        l = { "<C-w>l", "go-right" },
        m = { "<cmd>lua require('maximizer').toggle()<CR>", "maximize-toggle" },
        q = { "<cmd>wq<cr>", "quit" },
        s = { "<C-w>s<C-w>j", "split-down" },
        v = { "<C-w>v<C-w>l", "split-right" },
    },
    x = {
        name = "trouble",

        x = { "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", "document" },
        w = { "<cmd>Trouble toggle diagnostics focus=true<cr>", "workspace" },
        d = { "<cmd>Trouble toggle diagnostics<cr>", "document" },
        q = { "<cmd>Trouble toggle quickfix<cr>", "quickfix" },
        l = { "<cmd>Trouble toggle lclist<cr>", "loclist" },
        s = { "<cmd>Trouble symbols<cr>", "symbols" },
    },
    y = {
        name = "yank",
        y = { '"+y', "yank" },
        p = { '"+p', "paste" },
        P = { '"+P', "paste before" },
        j = { "<Plug>(YankyCycleForward)", "next yank" },
        k = { "<Plug>(YankyCycleBackward)", "previous yank" },
    },
    ["`"] = {
        name = "terminal",
        ['`'] = { '<cmd>ToggleTerm<cr>', 'toggle' },
        c = { '<cmd>lua require("toggleterm.terminal").Terminal:new({}).toggle()', "create-new" },
        f = { '<cmd>ToggleTerm direction="float"<cr>', 'toggle-float' },
        v = { '<cmd>ToggleTerm direction="vertical"<cr>', 'term-vertical' },
        h = { '<cmd>ToggleTerm direction="horizontal"<cr>', 'term-horisontal' },
        l = { '<cmd>ToggleTermSendCurrentLine<cr>', 'send-line' },
    },

    ["<Tab>"] = {
        name = "tabs",
        c = { "<cmd>tabnew<cr>", "new" },
        k = { "<cmd>tabclose<cr>", "kill" },
        n = { "<cmd>tabnext<cr>", "next" },
        ["<Tab>"] = { "<cmd>tabnext<cr>", "next" },
        p = { "<cmd>tabprevious<cr>", "previous" },
    },
    ["<leader>"] = { "<cmd>lua Modal('find_files')<cr>", "find files" },
    ["<enter>"] = { "<cmd>lua Modal('command_history')<cr>", "commands" },
}, { prefix = "<leader>", mode = "n" })

wk.register({
    f = { "<cmd><,>VBox<CR>", "box-surround" },
    ["<leader>"] = {
        y = { '"+y', "copy" }, -- copy to system clipboard
        c = { "<Plug>(comment_toggle_linewise_visual)", "comment" },
        r = { ":<C-U>REPLSendLines<cr>", "send-to-repl" },
        s = { '<cmd>ToggleTermSendVisualLines<cr>', 'send-visual' },
        S = { ":<C-U>sort<cr>", "sort" },
        ["el"] = { ':<C-u>call EvalLuaSelection()<CR>', "eval-lua" },
    },
}, { mode = "v" })

wk.register({
    ["<C-w>"] = {
        b = { "<cmd>lua ToggleWinBar()<cr>", "win-bar" }
    },
    ["<M-d>"] = { ":DapToggleBreakpoint<CR>", "bp-toggle" },
    ["<M-s>"] = { ":lua require('dap').step_over()<cr>", "step-over" },
    ["<M-o>"] = { ":lua require('dap').step_out()<cr>", "step-out" },
    ["<M-i>"] = { ":lua require('dap').step_into()<cr>", "step-into" },
    ["<M-l>"] = { "<cmd>set nu! rnu!<cr>", "line-numbers" },
    ["<M-c>"] = { ":lua require('dap').continue()<cr>", "continue" },
    ["<M-S-c>"] = { ":lua require('dap').close()<cr>", "close" },
}, { mode = "n" })

-- custom orgmode goto definition
api.nvim_create_autocmd({
    "FileType",
    "BufNewFile",
    "BufRead",
}, {
    pattern = "*.org",
    callback = function()
        keymap.set('n', 'gd', function()
            local roam = require("org-roam")
            roam.goto_id()
        end)
    end,
})

-- better goto definition for csharp
api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead",
}, {
    pattern = "*.cs",
    callback = function()
        keymap.set('n', 'gd', function()
            require('omnisharp_extended').lsp_definitions()
        end)

        keymap.set('n', 'vif', 'viW%', { noremap = true, silent = true })
    end,
})
