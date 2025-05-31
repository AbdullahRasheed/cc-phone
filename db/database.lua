local Database = {}
Database.__index = Database

function Database:new(name, path)
    local obj = setmetatable({}, self)
    obj.name = name
    obj.path = path

    return obj
end

local function getTableRaw(name)
    if name == nil then return nil end

    local tblFile = io.open(fs.combine(self.path, name), "r")
    if tblFile == nil then
        return nil
    end

    local out = textutils.unserialize(tblFile.readAll())
    tblFile.close()

    return out
end

function Database:getTable(name)
    return getTableRaw(name)["tbl"]
end

function Database:insertTableEntry(name, entry)
    local newTable = getTableRaw(name)
    local nextId = newTable["next_id"]

    newTable[nextId] = entry
    newTable["next_id"] = nextId + 1

    local file = io.open(fs.combine(self.path, name), "w")
    file.write(textutils.serialize(newTable))
end

return Database