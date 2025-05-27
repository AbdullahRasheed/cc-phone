local Database = require("database")
local ServerSocket = require("socket/serversocket")

local modem = peripheral.find("modem")
local port = 10

local server = ServerSocket:new(modem, port)

local sessions = {}

server:start(
    function(senderId, dist, packet)
        local reqType = packet["req_type"]
        if reqType == "connect" then
            -- Validate credentials (username / password or something)
            -- Create a unique session ID / hash associated with packet["dbName"],
            -- Send it back to the client
        elseif reqType == "get_table" then
            local sessionKey = packet["session_key"]
            local db = sessions[sessionKey]
            local resp = {}

            if db == nil then
                resp["code"] = "error"
                resp["err_msg"] = "Your session key is invalid."
            else
                local tblName = packet["table_name"]
                local tbl = db:getTable(tblName)
                if tbl == nil then
                    resp["code"] = "error"
                    resp["err_msg"] = "Either no table was provided or the table does not exist."
                else
                    resp["code"] = "success"
                    resp["table"] = tbl
                end
            end

            server:sendTo(senderId, resp)
        end
    end
)