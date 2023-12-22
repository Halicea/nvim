local dap = require("dap")
local fn = vim.fn

fn.sign_define("DapBreakpoint", { text = "🧅", texthl = "", linehl = "red", numhl = "" })
fn.sign_define("DapStopped", { text = "🥝", texthl = "", linehl = "green", numhl = "" })

local node_debug_path = "/home/halicea/projects/oss/vscode-node-debug2/out/src/nodeDebug.js"
dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { node_debug_path },
}

dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python",
    args = { "-m", "debugpy.adapter" },
}
dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}
dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.python = {
    {
        name = "Launch file",
        type = "python",
        request = "launch",
        program = "${file}",
        console = "externalTerminal",
        pythonPath = "/usr/bin/python",
    },
    {
        name = "Attach to process",
        type = "python",
        request = "attach",
        pythonPath = "/usr/bin/python",
        processId = require("dap.utils").pick_process,
    },
}

dap.configurations.typescript = {
    {
        name = "Launch",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/index.js",
        cwd = fn.getcwd(),
        stopOnEntry = true,
        sourceMaps = true,
        protocol = "inspector",
        console = "externalTerminal",
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = "Attach to process",
        type = "node2",
        request = "attach",
        sourceMaps = true,
        cwd = fn.getcwd(),
        processId = require("dap.utils").pick_process,
    },
}

dap.configurations.javascript = {
    {
        name = "Launch",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = fn.getcwd(),
        --stopOnEntry = true,
        sourceMaps = true,
        protocol = "inspector",
        console = "externalTerminal",
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
    },
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        justMyCode = false,
        program = function()
            return fn.input('Path to dll', fn.getcwd(), 'file')
        end,
    },
    {
        type = "coreclr",
        name = "attach - netcoredbg",
        justMyCode = false,
        request = "attach",
        processId = require("dap.utils").pick_process,
    },
}
