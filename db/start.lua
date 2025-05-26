local Database = require("database")

local modem = peripheral.find("modem")

-- USE SOCKET INSTEAD OF RAW MODEM

if modem == nil then
    error("Could not find modem.")
end

modem.open(10)

local sessions = {}

local event, side, channel, replyChannel, message, distance
while true do
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    local packet = textutils.unserialize(message)

    local reqType = packet["reqType"]
    if reqType == "connect" then
        -- Validate credentials (username / password or something)
        -- Create a unique session ID / hash associated with packet["dbName"],
        -- Send it back to the client
    elseif reqType == "getTable" then
        local sessionKey = packet["sessionKey"]
        local db = sessions[sessionKey]
        local resp = {}

        if db == nil then
            -- Send error response (DB not exist)
        else
            -- Get table (check if its null first)
            local tblName = packet["tableName"]
            local tbl = db:getTable(tblName)
            if tbl == nil then
                -- Send error response (Table not exist)
            else
                -- put in resp
                resp["code"] = "success"
                resp["table"] = tbl
                -- send

            end
        end
    end

end