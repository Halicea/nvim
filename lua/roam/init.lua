local sqlite = require "sqlite.db" --- for constructing sql databases
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local tscopeConfig = require("telescope.config").values

local function inspect(obj) print(vim.inspect(obj)) end
local strip = function(obj) return string.gsub(obj, "\"", "") end
local db = sqlite:open("/home/halicea/.config/emacs/.local/cache/org-roam.db")

local getDbData = function()
    local res = db:eval("SELECT * from nodes")
    return res
end

local search = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Roam Search",
        finder = finders.new_table {
            results = getDbData() ,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = strip(entry.title),--entry.title,
                    ordinal = strip(entry.title .. " " .. entry.file),
                    filename = strip(entry.file)
                }
            end
        },
        sorter = tscopeConfig.generic_sorter(opts),
    }):find()
end

local getById = function(id)
    local res = db:eval("SELECT * FROM 'nodes' WHERE id='\"" .. id .. "\"' LIMIT 1")
    if #res == 0 then
        return nil
    end
    return res[1].file
end

local open_id = function(id)
    local file = getById(id)
    if file == nil then
        print("No file found for id: " .. id)
        return
    end
    local cmd = "e " .. strip(file)
    inspect(cmd)
    vim.cmd(cmd)
end

local gotoIdUnderCursor = function()
    local str = vim.fn.expand('<cWORD>')
    inspect(str)
    local id = string.match(str, "id:([%w%-]+)")
    if id == nil then
        print("No id found")
        return
    end
    open_id(id)
end

return {
     search = search,
     getById = getById,
     gotoIdUnderCursor = gotoIdUnderCursor
}
