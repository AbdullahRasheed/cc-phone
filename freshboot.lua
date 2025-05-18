local persist = require("persistence")
local basalt = require("basalt")

local bootInfo = {
    fresh = true
}

local main = basalt.getMainFrame()
local font = main:addBigFont()
                :setText("Welcome!")
                :setPosition("{parent.width / 2}","{parent.height / 2}")
                :setBackground(colors.white)

local nameInput = main:addInput()
                    :setPlaceholder("Enter your name")
                    :setPattern("^[A-Za-z0-9 ]{0,32}$")

basalt.run()