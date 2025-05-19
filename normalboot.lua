local persist = require("persistence")
local basalt = require("basalt")

local file, err = fs.open("cc-phone/ico_default", "rb")
if not file then error("Could not open file: " .. err) end

local defaultIco = textutils.unserialize(file.readAll())
file.close()

if defaultIco == nil then
    error("Could not load default icon.. ill-formatted.")
end

local main = basalt.getMainFrame()

for i, filename in ipairs(fs.list("data/apps")) do
    local filepath = "data/apps/" .. filename .. "/metadata.lua"
    local meta = persist.load_table(filepath)
    local ico

    if meta["ico"] then
        local f = fs.open(fs.combine("data/apps/" .. filename, meta["ico"]))
        ico = textutils.unserialize(f.readAll())
        f.close()
    else
        ico = defaultIco
    end

    main:addImage({bimg = ico, autoResize = true})
        :setSize(math.floor(main.width / 3), math.floor(main.height / 3))
        :setPosition(((i-1) % 3) * math.floor(main.width / 3), math.floor((i-1) / 3) * math.floor(main.height / 4) + 1)
end

basalt.run()