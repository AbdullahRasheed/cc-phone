local ServerSocket = {}
ServerSocket.__index = ServerSocket

function ServerSocket:new(modem, port)
    local obj = setmetatable({}, self)
    obj.clients = {}
    obj.port = port
    obj.modem = modem

    modem.open(port)

    return obj
end

function ServerSocket:sendTo(senderId, msg)
    local packet = { recipient_id = senderId, message = msg }
    self.modem.transmit(self.port, self.port, packet)
end

function ServerSocket:replyTo(senderId, respId, msg)
    local packet = { recipient_id = senderId, resp_id = respId, message = msg }
    self.modem.transmit(self.port, self.port, packet)
end

function ServerSocket:broadcast(msg)
    local packet = { message = msg }
    for _, id in ipairs(self.clients) do
        packet["recipient_id"] = id
        self.modem.transmit(self.port, self.port, packet)
    end
end

function ServerSocket:start(handler)
    local event, side, channel, replyChannel, packet, distance
    while true do
        event, side, channel, replyChannel, packet, distance = os.pullEvent("modem_message")

        if packet == nil or type(packet) ~= "table" then
            -- Either ignore or send reply
            -- And maybe log
        else
            -- Check that this is a client-to-server message
            if packet["recipient_id"] == nil and packet["sender_id"] ~= nil then
                -- Maybe check if packet["message"] is nil first
                handler(packet["sender_id"], distance, packet["message"], 
                function(msg) 
                    self:replyTo(packet["sender_id"], packet["resp_id"], msg) 
                end)
            end
        end
    end
end

return ServerSocket