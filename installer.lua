local releasePath = ""
local devPath = "https://github.com/AbdullahRasheed/cc-phone"
local includePath = "https://github.com/AbdullahRasheed/cc-phone/include"
local args = {...}

local function getIncludes()
    local includes = {}
    local request = http.get(includePath)
    if request then
        for line in request:lines() do
            print(line)
        end
        request.close()
    else
        error("Failed to fetch include list")
    end
    return includes
end

print("Installing dev version...")
local includes = getIncludes()
if not includes then
    error("Failed to fetch include list")
end
-- local function downloadFile(url, path, name, size, currentFile, totalFiles)
--     print("Downloading " .. name..(size > 0 and " (" .. size/1000 .. " kb)" or "") .. " (" .. currentFile .. "/" .. totalFiles .. ")")
--     local request = http.get(url)
--     if request then
--         local file = fs.open(path, "w")
--         file.write(request.readAll())
--         file.close()
--         request.close()
--     else
--         error("Failed to download " .. name)
--     end
-- end
-- local totalFiles = 0
-- for _, category in pairs(config.categories) do
--     totalFiles = totalFiles + get(category.files)
-- end
-- local currentFile = 0
-- for categoryName, category in pairs(config.categories) do
--     for fileName, fileInfo in pairs(category.files) do
--         downloadFile(devPath .. fileInfo.path, fs.combine(args[2] or "basalt", fileInfo.path), fileName, fileInfo.size or 0, currentFile + 1, totalFiles)
--         currentFile = currentFile + 1
--     end
-- end
-- print("Dev installation complete!")
-- return
