local Socket = {}
Socket.__index = Socket

function Socket:new(modem, port)
    local obj = setmetatable({}, self)
    obj.modem = modem
    obj.port = port
    obj.awaitQueue = {}

    modem.open(port)

    return obj
end

function Socket:send(msg)
    local packet = { sender_id = os.getComputerID(), message = msg }
    self.modem.transmit(self.port, self.port, packet)
end

function Socket:awaitResponse(msg, handler)
    local packet = { sender_id = os.getComputerID(), message = msg }
    local timePart = os.time()
    local randPart = math.random(100000, 999999)
    packet["resp_id"] = timePart .. "-" .. randPart
    awaitQueue[packet["resp_id"]] = handler

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
            if packet["recipient_id"] == os.getComputerID() then
                -- Maybe check if packet["message"] is nil first
                local respId = packet["resp_id"]
                if respId ~= nil and self.awaitQueue[respId] ~= nil then
                    self.awaitQueue[respId](distance, packet["message"])
                    self.awaitQueue[respId] = nil
                else
                    handler(distance, packet["message"])
                end
            end
        end
    end
end

return Socket