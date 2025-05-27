local basalt = require("basalt")

local main = basalt.getMainFrame()

local catalog = main:addFrame({width = main.width, height = main.height, x = 0, y = 1, backgroundColor = colors.white})

-- Request DB for table of available items

-- Dummy item for now
createListing(0, 1)
createListing(0, 6)

local function createListing(lx, ly, itemInfo)
    local listing = catalog:addFrame({width = catalog.width, height = 5, x = lx, y = ly, backgroundColor = colors.gray})
    listing:addLabel()
        :setText("Some item")
        :setPosition(0, 1)
end