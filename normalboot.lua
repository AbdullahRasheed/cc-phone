local persist = require("persistence")
local basalt = require("basalt")

local defaultIco = loadfile("./ico_default")
if defaultIco == nil then
    error("Could not load default icon")
end

local main = basalt.getMainFrame()

for i, file in ipairs(fs.list("data/apps")) do
    local filepath = "data/apps/" .. file .. "/metadata.lua"
    local meta = persist.load_table(filepath)

    local ico = loadfile(fs.combine("data/apps/" .. file, meta["ico"]))
    main:addImage({bimg = ico or defaultIco, autoResize = true})
        :setSize(math.floor(main.width / 3), math.floor(main.height / 3))
        :setPosition(((i-1) % 3) * math.floor(main.width / 3), math.floor((i-1) / 3) * math.floor(main.height / 4) + 1)
end

basalt.run()