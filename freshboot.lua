local persist = require("persistence")
local basalt = require("basalt")

local bootInfo = {
    fresh = true
}

local main = basalt.getMainFrame()
local font = main:addBigFont()
                :setText("Welcome!")
                :setPosition("{math.floor(parent.width / 5)}","{math.floor(parent.height / 5)}")
                :setBackground(colors.white)
                :setWidth(24)

local nameInput = main:addInput()
                    :setPlaceholder("Enter your name")
                    :setWidth(20)

local setupButton = main:addButton()
                    :setText("Setup")
                    :onClick(function()
                        -- Create data/apps directory
                        -- Switch to next frame or perform normal boot
                        -- and then save bootInfo
                    end)

basalt.run()