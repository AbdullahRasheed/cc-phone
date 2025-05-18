local persist = require("persistence")
local basalt = require("basalt")

local bootInfo = {
    fresh = true
}

-- Here we know that bootInfo is a table, so this call is safe.
bootInfo = persist.load_default("data/boot_info.lua", bootInfo)

local main = basalt.getMainFrame()
local font = main:addBigFont()
                :setText("Welcome!")
                :setPosition("{parent.width}/2","{parent.height}/2")

basalt.run()

font:animate()
    :fadeText("text", "Welcome!", 2)
    :start()