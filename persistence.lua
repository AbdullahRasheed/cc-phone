local serializer = {}

function serializer.serialize(tbl)
    local result = "{\n"
    for k, v in pairs(tbl) do
        local key = type(k) == "string" and string.format("[%q]", k) or "[" .. tostring(k) .. "]"
        local value = (type(v) == "string") and string.format("%q", v) or tostring(v)
        result = result .. "  " .. key .. " = " .. value .. ",\n"
    end
    return result .. "}"
end

function serializer.save_table(filename, tbl)
    local file = assert(io.open(filename, "w"))
    file:write("return " .. serializer.serialize(tbl))
    file:close()
end

function serializer.load_table(filename)
    local chunk = loadfile(filename)
    return chunk and chunk()
end

local function inject_table(tbl, inj)
    for k, v in pairs(inj) do
        if type(tbl[k]) ~= type(v) then
            tbl[k] = v
        elseif type(v) == "table" then
            inject_table(tbl[k], v)
        end
    end
end

function serializer.load_default(filename, tbl)
    return inject_table(serializer.load_table(filename), tbl)
end

return serializer