local Socket = {}
Socket.__index = Socket

function Socket:new(modem, port)
    local obj = setmetatable({}, self)
    obj.modem = modem
    obj.port = port

    modem.open(port)

    return obj
end

function Socket:send(msg)
    local packet = { sender_id = os.getComputerID(), message = msg }
    self.modem.transmit(self.port, self.port, packet)
end

function Socket:start(handler)
    local event, side, channel, replyChannel, packet, distance
    while true do
        event, side, channel, replyChannel, packet, distance = os.pullEvent("modem_message")

        if packet == nil or type(packet) ~= "table" then
            -- Either ignore or send reply
            -- And maybe log
        else
            if packet["recipient_id"] == os.getComputerId() then
                -- Maybe check if packet["message"] is nil first
                handler(distance, packet["message"])
            end
        end
    end
end

return Socket