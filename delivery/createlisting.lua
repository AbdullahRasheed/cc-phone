local createlisting = {}

-- Still need to check that inputs are valid

function createlisting.form(container, backFrame)
    local frame = container:addFrame({width = container.width - 1, height = container.height - 1, x = 2, y = 2, background = colors.white})

    frame:addInput({maxLength = 24, placeholder = "Enter name..."})
        :setPosition(1, 1)
        :setSize(24, 1)

    frame:addInput({maxLength = 4, placeholder = "Enter quantity..."})
        :setPosition(1, 3)
        :setSize(24, 1)

    frame:addInput({maxLength = 15, placeholder = "Enter cost in $..."})
        :setPosition(1, 5)
        :setSize(24, 1)

    frame:addButton()
        :setPosition(1, 7)
        :onClick(function() 
            -- Lock button (so they cant spam click)
            -- Take from inventory and put in vault
            -- Add to DB
            -- Refresh catalog
            frame.visible = false
            backFrame.visible = true
        end)
    
    return frame
end

return createlisting