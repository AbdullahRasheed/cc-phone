local basalt = require("basalt")
local border = require("border")
local createform = require("createlisting")

local main = basalt.getMainFrame()

local catalog = main:addFrame({width = main.width, height = main.height, x = 1, y = 1, background = colors.white})

local newlisting = createform.form(main, catalog)
newlisting.visible = false

local head = catalog:addFrame({width = catalog.width, height = 1, x = 1, y = 1, background = colors.blue})
head:addButton()
    :setText("+")
    :setSize(2, 1)
    :setPosition(catalog.width - 2, 1)
    :onClick(function()
        catalog.visible = false
        newlisting.visible = true
    end)

-- Request DB for table of available items

-- Dummy item for now

local function createListing(lx, ly, itemInfo)
    local listing = catalog:addFrame({width = catalog.width, height = 5, x = lx, y = ly, background = colors.lightGray})
    border.border(listing, colors.black)

    listing:addLabel()
        :setText(itemInfo["name"])
        :setPosition(1, 1)
    
    local countStr = "x" .. itemInfo["count"]
    listing:addLabel()
        :setText(countStr)
        :setPosition(listing.width - #countStr, 1)

    listing:addLabel()
        :setText(itemInfo["desc"] or "")
        :setPosition(2, 2)

    local costStr = "$" .. itemInfo["cost"]
    listing:addLabel()
        :setText(costStr)
        :setPosition(listing.width - #costStr, listing.height - 1)
        :setForeground(colors.lime)
end

createListing(1, 3, {name = "Iron Ingot", count = 128, cost = 20})
createListing(1, 9, {name = "Cobblestone", count = 2048, cost = 5})

basalt.run()