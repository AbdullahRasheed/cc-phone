local persist = require("persistence")
local basalt = require("basalt")

local mds = {}

local function loadMetadata(filepath)
    local meta = persist.load_table(filepath)
    table.insert(mds, meta)
end

for _, file in ipairs(fs.list("data/apps")) do
    loadMetadata("data/apps/" .. file .. "/metadata.lua")
end

local main = basalt.getMainFrame()

local function render()
    for i, meta in ipairs(mds) do
        main:addButton()
            :setText(meta.name)
            :setWidth("{math.floor(parent.width / 3)}")
            :setPosition((i % 3) * math.floor(main.width / 3), math.floor(i / 3) * math.floor(main.height / 4))
    end
end