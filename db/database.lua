local Database = {}
Database.__index = Database

function Database:new(name, path)
    local obj = setmetatable({}, self)
    obj.name = name
    obj.path = path

    return obj
end

function Database:getTable(name)
    if name == nil then return nil end

    local tblFile = fs.open(fs.combine(self.path, name))
    if tblFile == nil then
        return nil
    end

    local out = textutils.unserialize(tblFile.readAll())
    tblFile.close()

    return out
end

return Database